Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2015 19:13:01 +0100 (CET)
Received: from smtp-out-084.synserver.de ([212.40.185.84]:1060 "EHLO
        smtp-out-084.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011292AbbAYSM7ee-2c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Jan 2015 19:12:59 +0100
Received: (qmail 25203 invoked by uid 0); 25 Jan 2015 18:12:59 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 25180
Received: from ppp-188-174-121-24.dynamic.mnet-online.de (HELO ?192.168.178.21?) [188.174.121.24]
  by 217.119.54.87 with AES256-SHA encrypted SMTP; 25 Jan 2015 18:12:59 -0000
Message-ID: <54C532A4.4090107@metafoo.de>
Date:   Sun, 25 Jan 2015 19:15:00 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 31/36] devicetree: document ingenic,jz4780-intc binding
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com> <1421620945-25502-1-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1421620945-25502-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45466
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

On 01/18/2015 11:42 PM, Paul Burton wrote:
[...]
> +Ingenic jz4780 SoC Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : should be "ingenic,jz4780-intc"

I don't think we need a second binding specification. Just add the 
compatibility string to the existing jz4740-intc specification.
