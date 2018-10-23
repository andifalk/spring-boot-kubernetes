package com.example.kubehello;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;

@ExtendWith(SpringExtension.class)
@DisplayName("Hello World Service")
@WebMvcTest(HelloRestController.class)
public class HelloRestControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@Test
	@DisplayName("returns expected message")
	@WithMockUser
	void verifySayHello() throws Exception {

		mockMvc.perform(get("/").accept(MediaType.APPLICATION_JSON_UTF8_VALUE))
			.andExpect(MockMvcResultMatchers.status().is2xxSuccessful())
			.andExpect(MockMvcResultMatchers.content().string("Hello Kubernetes"));

	}

	@Test
	@DisplayName("returns 401 error for message")
	void verifySayHello401() throws Exception {

		mockMvc.perform(get("/").accept(MediaType.APPLICATION_JSON_UTF8_VALUE))
			.andExpect(MockMvcResultMatchers.status().isUnauthorized());

	}

	@Test
	@DisplayName("returns expected custom message")
	@WithMockUser
	void verifyCustomizedSayHello() throws Exception {

		mockMvc.perform(post("/")
			.with(csrf())
			.accept(MediaType.APPLICATION_JSON_UTF8_VALUE)
			.contentType(MediaType.APPLICATION_JSON_UTF8_VALUE)
			.content("World"))
			.andExpect(MockMvcResultMatchers.status().is2xxSuccessful())
			.andExpect(MockMvcResultMatchers.content().string("Hello World"));

	}

	@Test
	@DisplayName("returns 401 for custom message")
	void verifyCustomizedSayHello401() throws Exception {

		mockMvc.perform(post("/")
			.with(csrf())
			.accept(MediaType.APPLICATION_JSON_UTF8_VALUE)
			.contentType(MediaType.APPLICATION_JSON_UTF8_VALUE)
			.content("World"))
			.andExpect(MockMvcResultMatchers.status().isUnauthorized());
	}

	@Test
	@DisplayName("returns 403 for custom message")
	@WithMockUser
	void verifyCustomizedSayHello403() throws Exception {

		mockMvc.perform(post("/")
			.accept(MediaType.APPLICATION_JSON_UTF8_VALUE)
			.contentType(MediaType.APPLICATION_JSON_UTF8_VALUE)
			.content("World"))
			.andExpect(MockMvcResultMatchers.status().isForbidden());

	}

}
