Return-Path: <SRS0=e5Bu=VN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D842C76192
	for <linux-mips@archiver.kernel.org>; Tue, 16 Jul 2019 13:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171572173C
	for <linux-mips@archiver.kernel.org>; Tue, 16 Jul 2019 13:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="b8dhUBZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfGPNGq (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:06:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40501 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPNGq (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 16 Jul 2019 09:06:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so9091681pfp.7
        for <linux-mips@vger.kernel.org>; Tue, 16 Jul 2019 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HndzIrwk0eloZ/VKZJ3ivaH1s8315qlKpsro16xZw70=;
        b=b8dhUBZSz3RGMnHXa2eQUBcpb0Fr1c6vhDDwn4sy14RwoF3LeMqo4GwVei/eUCKLfN
         2ysAKK0S6zo65plaT8Lmyu1cdKbX5vv5C3GPTJPIInad+mBHinkOAREnbCNuxmpL9VDG
         fvZUIwNFnzQNqEmzHkL0RRQ1MQkDpVZLaNNcaAVC/zAYUxremZf5+M3FMQbomiyN3wH4
         zc2zC/xff3jM5dpplZUlTKdEFImIprhxsju27ez6MU1i0OsgFNq72UzfzJW9Togr4CqO
         YkkRxSa2wlAwsL/E0oFuYOap/7lvKcKnsDSBvmk5MITFO2BYwQSiCBv4/QcWtaXdxpFP
         2++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HndzIrwk0eloZ/VKZJ3ivaH1s8315qlKpsro16xZw70=;
        b=mX/K96BJlPIM4BuUbhei/jtD7ggf5jbq2gkKtDQmhpJ2VMbIREoQsiAZFG/jpEb/4k
         MsnnDmMERAP17iO5ldSVDfXgPUUffYcsYKgflklohwxWaJLeQpGGlDmlbX2qmSd7C9tr
         PoAU8x0M8ZMfBtEq049hbmVsQfWlLe1I/i7PNRzz4w4oIZsfUzvVslxielpkHy0xuFTv
         dl61HC0vwCduBM2NFJkw8wUGTkFERemNUrNBk80JVjO6nwVux+nbO2pTlsc43iJsEm1A
         LwlXdknKQMopYfQqGwWKa5JOSsiefwmxOvB75wLlsim5M+fhePjliv2CiKS8xfCLha7U
         fq3Q==
X-Gm-Message-State: APjAAAVEhKbVOa2AXwSuxTtOKVv1jSDq7VA9J/jRYDaHH0XwOevI0JhN
        q+HlvCMMazDJUf9IS9rbEm4=
X-Google-Smtp-Source: APXvYqxc7HGOD0D5gu8WnhNrsT1I3LmFfpI6lWg9smWBUfjHYlbiTNFFnqhLddSt9tTLEeru8OLm5Q==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr33615344pgl.103.1563282405436;
        Tue, 16 Jul 2019 06:06:45 -0700 (PDT)
Received: from brauner.io ([172.58.30.188])
        by smtp.gmail.com with ESMTPSA id a12sm42618252pje.3.2019.07.16.06.06.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 06:06:44 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:06:33 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Message-ID: <20190716130631.tohj4ub54md25dys@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
> I think Vasily already has a clone3 patch for s390x with 435. 

A quick follow-up on this. Helge and Michael have asked whether there
are any tests for clone3. Yes, there will be and I try to have them
ready by the end of the this or next week for review. In the meantime I
hope the following minimalistic test program that just verifies very
very basic functionality (It's not pretty.) will help you test:

#define _GNU_SOURCE
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/sched.h>
#include <linux/types.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mount.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/sysmacros.h>
#include <sys/types.h>
#include <sys/un.h>
#include <sys/wait.h>
#include <unistd.h>

#ifndef CLONE_PIDFD
#define CLONE_PIDFD 0x00001000
#endif

#ifndef __NR_clone3
#define __NR_clone3 -1
#endif

static pid_t sys_clone3(struct clone_args *args)
{
	return syscall(__NR_clone3, args, sizeof(struct clone_args));
}

static int wait_for_pid(pid_t pid)
{
	int status, ret;

again:
	ret = waitpid(pid, &status, 0);
	if (ret == -1) {
		if (errno == EINTR)
			goto again;

		return -1;
	}

	if (ret != pid)
		goto again;

	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
		return -1;

	return 0;
}

#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))

int main(int argc, char *argv[])
{
	int pidfd = -1;
	pid_t parent_tid = -1, pid = -1;
	struct clone_args args = {0};

	args.parent_tid = ptr_to_u64(&parent_tid); /* CLONE_PARENT_SETTID */
	args.pidfd = ptr_to_u64(&pidfd); /* CLONE_PIDFD */
	args.flags = CLONE_PIDFD | CLONE_PARENT_SETTID;
	args.exit_signal = SIGCHLD;

	pid = sys_clone3(&args);
	if (pid < 0) {
		fprintf(stderr, "%s - Failed to create new process\n", strerror(errno));
		exit(EXIT_FAILURE);
	}

	if (pid == 0) {
		printf("Child process with pid %d\n", getpid());
		exit(EXIT_SUCCESS);
	}

	printf("Parent process received child's pid %d as return value\n", pid);
	printf("Parent process received child's pidfd %d\n", *(int *)args.pidfd);
	printf("Parent process received child's pid %d as return argument\n",
	       *(pid_t *)args.parent_tid);

	if (wait_for_pid(pid))
		exit(EXIT_FAILURE);

	if (pid != *(pid_t *)args.parent_tid)
		exit(EXIT_FAILURE);

	close(pidfd);

	return 0;
}
