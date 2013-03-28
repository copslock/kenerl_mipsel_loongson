Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Mar 2013 23:25:14 +0100 (CET)
Received: from mail-ea0-f178.google.com ([209.85.215.178]:63908 "EHLO
        mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834890Ab3C1WZNor3fE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Mar 2013 23:25:13 +0100
Received: by mail-ea0-f178.google.com with SMTP id o10so9326eaj.23
        for <linux-mips@linux-mips.org>; Thu, 28 Mar 2013 15:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-type:content-transfer-encoding
         :x-mailer:thread-index:content-language:x-gm-message-state;
        bh=Lsa0BWGHxGQ/cuoeazoDvGsVDnzviM5X07N3Thk3RAY=;
        b=JJbDyuvcaac2xmvFFPOZxPfcGaAWQOfqTD0Z4ZtjRA08cJ8c7Xfy4gxfz9Ba0TLBdA
         FsaYKBPEbQLnhzfjDhBWNhD0jnoitutgEP6qeKS6181uDbzC4eMzRpVB4VJNUeOeOhvH
         nlOFTLa30LM4pjVoPBeKefrqqP9AT6gNHSyh1hPGdRQ+oEeKQ2bNHPmUlZ4N5HL2K09Q
         3R5wmLSjvBzOgA1OlskZTpsQYhMAm2qfuDOL13KsY40J/2LzEXEj6y4mwmwmvrvLKgLp
         dUBtWZ7cl/0tOR9RyeUJIB0N2xb4ofOsX3iLAdLnkP7B9lM6TKlM0c6SB/tjF8uJkR/S
         t9KQ==
X-Received: by 10.14.1.130 with SMTP id 2mr966599eed.15.1364509508326;
        Thu, 28 Mar 2013 15:25:08 -0700 (PDT)
Received: from hotrod ([77.70.100.51])
        by mx.google.com with ESMTPS id a1sm695167eep.2.2013.03.28.15.25.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 15:25:07 -0700 (PDT)
From:   "Svetoslav Neykov" <svetoslav@neykov.name>
To:     "'Alexander Shishkin'" <alexander.shishkin@linux.intel.com>,
        "'Ralf Baechle'" <ralf@linux-mips.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Gabor Juhos'" <juhosg@openwrt.org>,
        "'John Crispin'" <blogic@openwrt.org>,
        "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>
Cc:     <linux-mips@linux-mips.org>, <linux-usb@vger.kernel.org>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name> <1362176257-2328-2-git-send-email-svetoslav@neykov.name> <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com>
Subject: RE: [PATCH v2 1/2] usb: chipidea: big-endian support
Date:   Fri, 29 Mar 2013 00:25:02 +0200
Message-ID: <023c01ce2c03$1886e220$4994a660$@neykov.name>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
thread-index: AQJ6crEKrmvOIJbIiJ7dXEbCRe8hgQIpA3+vAboxlnWXRAbC0A==
Content-Language: bg
X-Gm-Message-State: ALoCoQn8tlc0W6uVakl4ulC6zfYGl+f8FayexdiOxJCgaGqcTb/2jWstAE2QEw7jTVEFrtr2JLLM
X-archive-position: 35992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetoslav@neykov.name
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

Alexander Shishkin wrote:
> Svetoslav Neykov <svetoslav@neykov.name> writes:
>
>> Convert between big-endian and little-endian format when accessing the
usb controller structures which are little-endian by specification.
>> Fix cases where the little-endian memory layout is taken for granted.
>> The patch doesn't have any effect on the already supported
>> little-endian architectures.
>
>Applied to my branch of things that are aiming at v3.10. Next time
>please make sure that it applies cleanly.

I am a bit confused about the workflow and which repository to base my work
on. Should I use github/virtuoso/linux-ci for my future patches? Or
linux-next?

Regards,
Svetoslav.
