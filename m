Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2012 19:22:40 +0200 (CEST)
Received: from forward20.mail.yandex.net ([95.108.253.145]:60185 "EHLO
        forward20.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903706Ab2GWRWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jul 2012 19:22:35 +0200
Received: from web3g.yandex.ru (web3g.yandex.ru [95.108.252.103])
        by forward20.mail.yandex.net (Yandex) with ESMTP id 37B661042C7E;
        Mon, 23 Jul 2012 21:22:29 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1343064149; bh=ciB0e/Tov2bVNZ6oW4S1LZLVJTSmkpxKNVlkcWFi7pk=;
        h=From:To:Cc:In-Reply-To:References:Subject:MIME-Version:Message-Id:
         Date:Content-Transfer-Encoding:Content-Type;
        b=v5JT6S31us1gvPNHIMhRShXODqSt4WWsd7NILhsw5gHDUdh6LqK5iqszKvYoQ+Joi
         aw7tGZrMh9roTo3FDiss39JrV0F/sw3qFMTizo4+VNZpKJOJkz1h2GrFvOmi9ndump
         oXviv+7OSmNDVhk6Nx6JDOVdEhnOKtAdwrDLMTa8=
Received: from 127.0.0.1 (localhost.localdomain [127.0.0.1])
        by web3g.yandex.ru (Yandex) with ESMTP id CFC31208802C;
        Mon, 23 Jul 2012 21:22:28 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1343064149; bh=ciB0e/Tov2bVNZ6oW4S1LZLVJTSmkpxKNVlkcWFi7pk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date;
        b=b6yBI0VBjeF9c1tgZTL6A6K6xh34b2NCjjPozLmTZBMmKYYBdNlt2CwH6wpWcr9ZB
         1/LWJwcBKvs+LFZMDD2aswHMpk3C/7LNQi2x65AJc2s1gO9T+rORiBjiAdGH5g2RMi
         DCgOCPsj3PrDfyypPCVmO5vA/pijHj+3n8l3jcUo=
Received: from wimax-client.yota.ru (wimax-client.yota.ru [178.176.237.110]) by web3g.yandex.ru with HTTP;
        Mon, 23 Jul 2012 21:22:28 +0400
From:   kr kr <kr-jiffy@yandex.ru>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <20120720091602.GA15546@linux-mips.org>
References: <194011342123405@web6e.yandex.ru> <20120720091602.GA15546@linux-mips.org>
Subject: Re: [mips32r1 cpu] Advice needed: "Machine Check exception - caused by multiple matching entries in the TLB"
MIME-Version: 1.0
Message-Id: <189641343064148@web3g.yandex.ru>
Date:   Mon, 23 Jul 2012 21:22:28 +0400
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=koi8-r
X-archive-position: 33956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kr-jiffy@yandex.ru
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

20.07.2012, 13:16, "Ralf Baechle" <ralf@linux-mips.org>:
> On Fri, Jul 13, 2012 at 12:03:25AM +0400, kr kr wrote:
>
>> š[ šš12.560000] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
>
> Running userland should never result in crashing the kernel except if
> programs directly touch I/O hardware an do stupid things or abuse their
> root priviledges..
>
> This type of crash specifically has in the past been produced by incorrect
> hazard barriers but also CPU hardware bugs so you may want to review the
> kernel code against a CPU datasheet and errata documentation. šAs always
> with hardware that is only supported out of tree we can't be too helpful ...
>
> ššRalf

Ok, thank you.
But, in case of, say, Malta, we don't need to turn on (or turn off) some special CONFIG_* options in order to make it run MIPS-I binaries (which Debian provides), whereas MIPS32 binaries are native for the board?

Yuri
