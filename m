Return-Path: <SRS0=95ey=TW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B4CC282CE
	for <linux-mips@archiver.kernel.org>; Wed, 22 May 2019 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DD020879
	for <linux-mips@archiver.kernel.org>; Wed, 22 May 2019 15:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RYzExnyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfEVPxi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 22 May 2019 11:53:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43807 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbfEVPxh (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 22 May 2019 11:53:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so2583792wrr.10
        for <linux-mips@vger.kernel.org>; Wed, 22 May 2019 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yF9i8CBoIre9ittu6TL9sPlugb9HPbhX86BuS4x2hi8=;
        b=RYzExnyoOv3w5Fb8VLaJHKEDYxs4aenFqlTgzrIoyILRfHlvMh2wGo5lxkZtzBmSIr
         kOGCfp5ne9EqBjqB6SzVHfmT6akW35gkdJVszwCJfKB8OV9YsU+yLxNBGrh9EpI2AGJh
         UC9CvWQkTTUhhU+Qs7HlgDA9/qRwQSTqEeE1QaaLxOvM3rcT5L1U8BZ/5wc1ZG5x0i7E
         oVzw1tA9/4XF6mpiT+HTIGS38DpLhBMAGWhCo8hqTjqdKKGpJ7IGV/2j7ZITikN0fESr
         Plage1J7mGBtdyltzXMUFjtQKVS37nFTFKuGUm5GPSBVyEtAs/0A2m/IvTHzNtOz+P81
         l4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yF9i8CBoIre9ittu6TL9sPlugb9HPbhX86BuS4x2hi8=;
        b=lj4cW2PlM6G3LeUViObl9Tv1te+yDDl7SiZLA4Hxa4s6+4+JlofGRm5AxTgc7cnywc
         uJFhu+bK9qOO3zXxyx9Zny5zcDf8dFtZ8iIg5+imltRlbubFb8aBEkFQcf1M7HMgp2xz
         dNALhWZcAtDlFar33rjX7F3KSBeQSvaBKjQSKK/jnJQCsCtitqv3J0o+AQhSxR8NmZwu
         ZADzrK/nC0JmQyvkaMNCPnKIoMJGJJm27Uxhs48cz+Fe3UCvRwFsKmAvh8jrPgKt71iA
         ZiFqrz71c8OrjEai1hIFk0Smhy5TLjRvF71ReNRyeu2SP+RKVZnZsIcGwWTjZaC34W6A
         LU2A==
X-Gm-Message-State: APjAAAWA+7Z/RnjvBIgiWvOdoOTH6lFTUvFrFNyuzHcKVQm+803krMJd
        4lDHJQXM57PjCH5tSpoKXuinVg==
X-Google-Smtp-Source: APXvYqxptX7r7Y8CjJpjVCMVuUuAEbDzgoOyVNwuGDnMbTihy60ncTFvjTKE97l9juX0zFfMwBxjdQ==
X-Received: by 2002:adf:ce89:: with SMTP id r9mr6992995wrn.300.1558540415392;
        Wed, 22 May 2019 08:53:35 -0700 (PDT)
Received: from localhost.localdomain ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id t12sm15677263wro.2.2019.05.22.08.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:53:34 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, fweimer@redhat.com
Cc:     jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 2/2] tests: add close_range() tests
Date:   Wed, 22 May 2019 17:52:59 +0200
Message-Id: <20190522155259.11174-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522155259.11174-1-christian@brauner.io>
References: <20190522155259.11174-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This adds basic tests for the new close_range() syscall.
- test that no invalid flags can be passed
- test that a range of file descriptors is correctly closed
- test that a range of file descriptors is correctly closed if there there
  are already closed file descriptors in the range
- test that max_fd is correctly capped to the current fdtable maximum

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dmitry V. Levin <ldv@altlinux.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: linux-api@vger.kernel.org
---
v1: unchanged
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/core/.gitignore       |   1 +
 tools/testing/selftests/core/Makefile         |   6 +
 .../testing/selftests/core/close_range_test.c | 128 ++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/core/.gitignore
 create mode 100644 tools/testing/selftests/core/Makefile
 create mode 100644 tools/testing/selftests/core/close_range_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9781ca79794a..06e57fabbff9 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -4,6 +4,7 @@ TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += capabilities
 TARGETS += cgroup
+TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
diff --git a/tools/testing/selftests/core/.gitignore b/tools/testing/selftests/core/.gitignore
new file mode 100644
index 000000000000..6e6712ce5817
--- /dev/null
+++ b/tools/testing/selftests/core/.gitignore
@@ -0,0 +1 @@
+close_range_test
diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
new file mode 100644
index 000000000000..de3ae68aa345
--- /dev/null
+++ b/tools/testing/selftests/core/Makefile
@@ -0,0 +1,6 @@
+CFLAGS += -g -I../../../../usr/include/ -I../../../../include
+
+TEST_GEN_PROGS := close_range_test
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
new file mode 100644
index 000000000000..ab10cd205ab9
--- /dev/null
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/kernel.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
+				  unsigned int flags)
+{
+	return syscall(__NR_close_range, fd, max_fd, flags);
+}
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+int main(int argc, char **argv)
+{
+	const char *test_name = "close_range";
+	int i, ret;
+	int open_fds[100];
+	int fd_max, fd_mid, fd_min;
+
+	ksft_set_plan(7);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				ksft_exit_skip(
+					"%s test: skipping test since /dev/null does not exist\n",
+					test_name);
+
+			ksft_exit_fail_msg(
+				"%s test: %s - failed to open /dev/null\n",
+				strerror(errno), test_name);
+		}
+
+		open_fds[i] = fd;
+	}
+
+	fd_min = open_fds[0];
+	fd_max = open_fds[99];
+
+	ret = sys_close_range(fd_min, fd_max, 1);
+	if (!ret)
+		ksft_exit_fail_msg(
+			"%s test: managed to pass invalid flag value\n",
+			test_name);
+	ksft_test_result_pass("do not allow invalid flag values for close_range()\n");
+
+	fd_mid = open_fds[50];
+	ret = sys_close_range(fd_min, fd_mid, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close range of file descriptors from 4 to 50\n",
+			test_name);
+	ksft_test_result_pass("close_range() from %d to %d\n", fd_min, fd_mid);
+
+	for (i = 0; i <= 50; i++) {
+		ret = fcntl(open_fds[i], F_GETFL);
+		if (ret >= 0)
+			ksft_exit_fail_msg(
+				"%s test: Failed to close range of file descriptors from 4 to 50\n",
+				test_name);
+	}
+	ksft_test_result_pass("fcntl() verify closed range from %d to %d\n", fd_min, fd_mid);
+
+	/* create a couple of gaps */
+	close(57);
+	close(78);
+	close(81);
+	close(82);
+	close(84);
+	close(90);
+
+	fd_mid = open_fds[51];
+	/* Choose slightly lower limit and leave some fds for a later test */
+	fd_max = open_fds[92];
+	ret = sys_close_range(fd_mid, fd_max, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close range of file descriptors from 51 to 100\n",
+			test_name);
+	ksft_test_result_pass("close_range() from %d to %d\n", fd_mid, fd_max);
+
+	for (i = 51; i <= 92; i++) {
+		ret = fcntl(open_fds[i], F_GETFL);
+		if (ret >= 0)
+			ksft_exit_fail_msg(
+				"%s test: Failed to close range of file descriptors from 51 to 100\n",
+				test_name);
+	}
+	ksft_test_result_pass("fcntl() verify closed range from %d to %d\n", fd_mid, fd_max);
+
+	fd_mid = open_fds[93];
+	fd_max = open_fds[99];
+	/* test that the kernel caps and still closes all fds */
+	ret = sys_close_range(fd_mid, UINT_MAX, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close range of file descriptors from 51 to 100\n",
+			test_name);
+	ksft_test_result_pass("close_range() from %d to %d\n", fd_mid, fd_max);
+
+	for (i = 93; i < 100; i++) {
+		ret = fcntl(open_fds[i], F_GETFL);
+		if (ret >= 0)
+			ksft_exit_fail_msg(
+				"%s test: Failed to close range of file descriptors from 51 to 100\n",
+				test_name);
+	}
+	ksft_test_result_pass("fcntl() verify closed range from %d to %d\n", fd_mid, fd_max);
+
+	return ksft_exit_pass();
+}
-- 
2.21.0

