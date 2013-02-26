Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Feb 2013 15:39:07 +0100 (CET)
Received: from mail-ee0-f45.google.com ([74.125.83.45]:38138 "EHLO
        mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820301Ab3BZOjEGzGsZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Feb 2013 15:39:04 +0100
Received: by mail-ee0-f45.google.com with SMTP id b57so2344820eek.4
        for <linux-mips@linux-mips.org>; Tue, 26 Feb 2013 06:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-type:content-transfer-encoding
         :x-mailer:thread-index:content-language:x-gm-message-state;
        bh=MqkHjRT/6InU8FH1XU2wcv58o2lzObGTpx/2gFKCRbk=;
        b=TK9C292mf3UlSKv4NDct5dnkf2IIIQd0CFxlE9cjJ5LcNOTcGQsQQo8sgFVQ6VAHLN
         2Uarc9LqhM7x+CtPdSpewJLPMydHHHktnvILhPCVQprS2kKfEj8QjAHWfpHoOIS5yvoy
         /ESBSTNIJWOw6L2t5IJ45DxtOM2re/w67n1l8kWt+Im3h186rgBfkqGXD/Rd2h6Tl64r
         W5VmZiT4ETD4+kAEs6kAO6aZSjM+om9vx/H7erqDMllqJm6rBoWgnKk0Tk9gp5/YsGJk
         qpFqKgSGC0TlApOpt116ImQRCIFhCDGzLfrVlpj7jBLRKaHucUiv2ohP/hMxo+BaJOAy
         9fSw==
X-Received: by 10.14.210.132 with SMTP id u4mr50314729eeo.19.1361889538276;
        Tue, 26 Feb 2013 06:38:58 -0800 (PST)
Received: from hotrod ([77.70.100.51])
        by mx.google.com with ESMTPS id l8sm1792933een.10.2013.02.26.06.38.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 06:38:57 -0800 (PST)
From:   "Svetoslav Neykov" <svetoslav@neykov.name>
To:     "'Alexander Shishkin'" <alexander.shishkin@linux.intel.com>,
        "'Ralf Baechle'" <ralf@linux-mips.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Gabor Juhos'" <juhosg@openwrt.org>,
        "'John Crispin'" <blogic@openwrt.org>,
        "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>
Cc:     <linux-mips@linux-mips.org>, <linux-usb@vger.kernel.org>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name> <87k3pvxkn8.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87k3pvxkn8.fsf@ashishki-desk.ger.corp.intel.com>
Subject: RE: [PATCH 0/5] Chipidea driver support for the AR933x platform
Date:   Tue, 26 Feb 2013 16:38:53 +0200
Message-ID: <078801ce142f$0108dea0$031a9be0$@neykov.name>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
thread-index: AQGDG6p+wHZ3zGBMHoZ7+PlD69kkYAF6L3a2mRZUdmA=
Content-Language: bg
X-Gm-Message-State: ALoCoQnhfKQxoZN9IBv/smSSd2KgKEttAp40pGoCp02y16tIHmcuJq4taHJebs2hw6cZbjw0w0cg
X-archive-position: 35823
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

Hi Alex,
I am working on the incorporating all received comments - thanks to all for
taking their time to comment.
Apologies for not replying to the received mails, didn't want to spam with
OK replies to each separately.

Regards,
Svetoslav.


-----Original Message-----
From: Alexander Shishkin [mailto:alexander.shishkin@linux.intel.com] 
Sent: Tuesday, February 26, 2013 3:36 PM
To: Svetoslav Neykov; Ralf Baechle; Greg Kroah-Hartman; Gabor Juhos; John
Crispin; Alan Stern; Luis R. Rodriguez
Cc: linux-mips@linux-mips.org; linux-usb@vger.kernel.org; Svetoslav Neykov
Subject: Re: [PATCH 0/5] Chipidea driver support for the AR933x platform

Svetoslav Neykov <svetoslav@neykov.name> writes:

> Add support for the usb controller in AR933x platform.
> The processor is big-endian so all multi-byte values of the usb 
> descriptors must be converted explicitly. Another difference is that
> the controller supports both host and device modes but not OTG.
> The patches are tested on WR703n router running OpenWRT trunk.

Svetoslav, are you working on these or do you have time to address the
issues raised in review?

Thanks,
--
Alex
