Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2015 19:22:02 +0100 (CET)
Received: from smtp-out-084.synserver.de ([212.40.185.84]:1094 "EHLO
        smtp-out-084.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011162AbbAYSWBkap8H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Jan 2015 19:22:01 +0100
Received: (qmail 15844 invoked by uid 0); 25 Jan 2015 18:21:53 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 15771
Received: from ppp-188-174-121-24.dynamic.mnet-online.de (HELO ?192.168.178.21?) [188.174.121.24]
  by 217.119.54.96 with AES256-SHA encrypted SMTP; 25 Jan 2015 18:21:53 -0000
Message-ID: <54C534B8.6070909@metafoo.de>
Date:   Sun, 25 Jan 2015 19:23:52 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     linux-mips@linux-mips.org, Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 16/36] MIPS,clk: migrate jz4740 to common clock framework
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com> <1421620591-24274-1-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1421620591-24274-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 01/18/2015 11:36 PM, Paul Burton wrote:
> +	[JZ4740_CLK_EXT] = { "ext", CGU_CLK_EXT },
> +	[JZ4740_CLK_RTC] = { "rtc", CGU_CLK_EXT },

Should we really add the external clocks as outputs to the CGU?
