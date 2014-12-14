Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Dec 2014 21:36:52 +0100 (CET)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:39471 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008610AbaLNUgu5L0uq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Dec 2014 21:36:50 +0100
Received: by mail-wg0-f49.google.com with SMTP id n12so13016357wgh.22
        for <linux-mips@linux-mips.org>; Sun, 14 Dec 2014 12:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eqrzihw3xTaBijZ1AoDbK1+BatD9eqvcQheOwhQDOAQ=;
        b=lpUtv7qMvdfpopPWCxK/UZrDJv3gIEC8G7A2+rVtq+JndidEPFaq6y8WWIpSAjP1vj
         7UrYbBpJMyKBdWQJkKb5CGSaSuPymDpSs/dIsyoPhYFCu1xkAbEAuHLK7bFaG4xNKpFW
         PmIe43+VyxnEK5GyWMYZnE/bYffqh5b0SjeyAE6vhrOinJUcTz0gDS0V+D6JQwynu6zE
         XMDdqkJDKrngZPrdzu6XxHpmf5bnkrgIRi4hOb6EX6xROBnO/w4GWzF4KTWU4YvXg0Nh
         M9nSyHGLG7o7m5vigYooNf+xqoUqBMmyicF4UwLjcigcDk0A555QOpDBt881o/iN596d
         +YMQ==
X-Gm-Message-State: ALoCoQk18SeYKsGMJXaCbFDang5o0289RhFxqGEweAvVtH9JUM0Sy6b1ovDoHbTdSmzf3sY5jBwh
X-Received: by 10.180.85.34 with SMTP id e2mr26140757wiz.0.1418589403943;
        Sun, 14 Dec 2014 12:36:43 -0800 (PST)
Received: from bordel.klfree.net (bordel.klfree.cz. [81.201.48.42])
        by mx.google.com with ESMTPSA id pl1sm10659631wic.16.2014.12.14.12.36.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Dec 2014 12:36:42 -0800 (PST)
Date:   Sun, 14 Dec 2014 21:36:36 +0100
From:   Petr Malat <oss@malat.biz>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Provide correct siginfo_t.si_stime
Message-ID: <20141214203636.GA4866@bordel.klfree.net>
References: <20141212142800.GA4176@bordel.klfree.net>
 <548B21C8.7020409@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <548B21C8.7020409@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <oss@malat.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oss@malat.biz
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 12, 2014 at 09:11:36AM -0800, David Daney wrote:
> Please state how this patch effects binary compatibility with
> previous releases of the kernel.

Hi David,
the kernel returns a random value in the field si_stime. With the patch
applied, the correct value is present in the field. This is the only 
change visible in userspace, because copy_siginfo() is used just for 
coping done in kernel. To the userspace data are copried by a different
function - copy_siginfo_to_user(), which copies field by field, so 
information leakage caused by this change is not possible.

Here is an output from a program (attached), which illustrates the 
issue:

X86_64:
usage.ru_stime 1000 ms
info->si_stime 1000 ms (64)

MIPS (Octeon) with the patch applied:
usage.ru_stime 1000 ms
info->si_stime 1000 ms (64)

MIPS (Octeon) without the patch (3 executions): 
usage.ru_stime 1000 ms
info->si_stime 5532471680 ms (20f9e1c0)
usage.ru_stime 1000 ms
info->si_stime 5532484000 ms (20f9e690)
usage.ru_stime 1000 ms
info->si_stime 5532484640 ms (20f9e6d0)

Regards,
  Petr  

--VbJkn9YxBvnuCH5J
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="burn.c"

//
// Fork a child, which spends 1 second in system and print
// stime obtained from getrusage and stime received in siginfo
// of the SIGCHLD
//

#include <sys/resource.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

void handler(int sig, siginfo_t *info, void *context)
{
	printf("info->si_stime %ld ms (%lx)\n", 
			1000 * info->si_stime / sysconf(_SC_CLK_TCK),
			info->si_stime);
}

int main(int argc, char *argv[])
{
	struct sigaction act = { .sa_sigaction = handler, .sa_flags = SA_SIGINFO };
	sigaction(SIGCHLD, &act, NULL);

	if (fork()) {
		wait(NULL);
	} else {
		struct rusage usage;
		do {
			int fd = open("/proc/self/maps", O_RDONLY);
			char buf[4096];

			read(fd, buf, sizeof buf);
			close(fd);
			getrusage(RUSAGE_SELF, &usage);
		} while (usage.ru_stime.tv_sec < 1);
		printf("usage.ru_stime %ld ms\n", 
			1000 * usage.ru_stime.tv_sec + 
			usage.ru_stime.tv_usec / 1000);
	}
	return 0;
}

--VbJkn9YxBvnuCH5J--
