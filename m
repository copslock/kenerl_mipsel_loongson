Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2014 17:58:27 +0200 (CEST)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:48386 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839029AbaEGP6VkJBAA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2014 17:58:21 +0200
Received: by mail-lb0-f176.google.com with SMTP id p9so1689160lbv.35
        for <linux-mips@linux-mips.org>; Wed, 07 May 2014 08:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=YEt6vP/JTJOczNbCzug3mN3Ie/1apJUaDdo/bWIBWgU=;
        b=ctG2gAnIoDKh1TwIIMSPo+XbJQVnHdy9+k98aqaiFM0Bjks3Yn8tr5ge3Y8W0xCqWd
         nkrjqy4R4Bb2VB9diYTrgPlOcs4auPD6pfiXL4WXLfMOw2fWD1kOUljOXQAha/lIsWQe
         wCswIGXQN7ZifL8W1KgW6m1R59JEtiz66uTS+17fkaV+KGPyJItmJKdHPYBUD7UCDj18
         en2/D5Sqzq3e5ZS2r2siIqQ3s6gO56+e6nzM2wEjWvLisqtGBocxeGORyxSvH7bQ+ejf
         hKj2LVe8ywy7s9lCjBcWrzWLy7ia4J30qTyT7KkJ3mihd0r0Tsle7hGodd/wQOo7Yzhm
         A+0Q==
X-Gm-Message-State: ALoCoQla6dCEw/3tFBQwsZf2zKIozMAaHasC5kqfTr70F5UW1VrPuRfxagBdlO5/55dSoQEXSFBJ
X-Received: by 10.112.180.225 with SMTP id dr1mr3843177lbc.51.1399478294913;
        Wed, 07 May 2014 08:58:14 -0700 (PDT)
Received: from [192.168.2.4] (ppp85-140-133-75.pppoe.mtu-net.ru. [85.140.133.75])
        by mx.google.com with ESMTPSA id d4sm17454781lbr.27.2014.05.07.08.58.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 08:58:14 -0700 (PDT)
Message-ID: <536A5826.6010008@cogentembedded.com>
Date:   Wed, 07 May 2014 19:58:30 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 11/11] kvm tools: Modify term_putc to write more than
 one char
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1399391491-5021-12-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1399391491-5021-12-git-send-email-andreas.herrmann@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 06-05-2014 19:51, Andreas Herrmann wrote:

> From: David Daney <david.daney@cavium.com>

> It is a performance enhancement. When running in a simulator, each
> system call to write a character takes a lot of time.  Batching them
> up decreases the overhead (in the root kernel) of each virtio console
> write.

> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>   tools/kvm/term.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/tools/kvm/term.c b/tools/kvm/term.c
> index 3de410b..b153eed 100644
> --- a/tools/kvm/term.c
> +++ b/tools/kvm/term.c
> @@ -52,11 +52,14 @@ int term_getc(struct kvm *kvm, int term)
>   int term_putc(char *addr, int cnt, int term)
>   {
>   	int ret;
> +	int num_remaining = cnt;
>
> -	while (cnt--) {
> -		ret = write(term_fds[term][TERM_FD_OUT], addr++, 1);
> +	while (num_remaining) {
> +		ret = write(term_fds[term][TERM_FD_OUT], addr, num_remaining);
>   		if (ret < 0)
>   			return 0;

    Perhaps 'return cnt - num_remaining' instead?

> +		num_remaining -= ret;
> +		addr += ret;
>   	}
>
>   	return cnt;

WBR, Sergei
