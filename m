Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Mar 2013 23:23:50 +0100 (CET)
Received: from mail-ee0-f54.google.com ([74.125.83.54]:42644 "EHLO
        mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834891Ab3C1WXtq90bf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Mar 2013 23:23:49 +0100
Received: by mail-ee0-f54.google.com with SMTP id e51so8459eek.41
        for <linux-mips@linux-mips.org>; Thu, 28 Mar 2013 15:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-type:content-transfer-encoding
         :x-mailer:thread-index:content-language:x-gm-message-state;
        bh=wJ9oq0qM6q8PDl7buIoW1fhkQQXRbbBmhEyMGjav1OY=;
        b=h5DAAIu0nW3PvRwGKYZohSqJR++Xw2W9TB07J3baRp2H91z2eOfZ/tDg+aM9vMjOZy
         EqtkjjaiWpmkUcESYTxjozZ7wlKdUSHpR/3E78lyumeHaQ4F7rCMGFLWa20Yf6GV1vtA
         QUmfr17GL3yMa5N/M0GlmoL+p2Hqo+0AQf/7fXzk8uKJQSVgBZggA6ueOJJlOAhgg5TU
         y6/9HcP4hx9y1TeVPKigrtoxlD+CjVHOg6k1czk1L3vwxUsjDSyIQpUZX1VngeXAkq5i
         7VeqjA20hSgfOU5whzU+sG8fbj0fQEjQTGtQOZzK7TQ1oYQXM+Cq75rCH6rcASxPQpAT
         wf/Q==
X-Received: by 10.14.215.193 with SMTP id e41mr813952eep.32.1364509423649;
        Thu, 28 Mar 2013 15:23:43 -0700 (PDT)
Received: from hotrod ([77.70.100.51])
        by mx.google.com with ESMTPS id n2sm601870eeo.10.2013.03.28.15.23.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 15:23:42 -0700 (PDT)
From:   "Svetoslav Neykov" <svetoslav@neykov.name>
To:     "'Alexander Shishkin'" <alexander.shishkin@linux.intel.com>,
        "'Ralf Baechle'" <ralf@linux-mips.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Gabor Juhos'" <juhosg@openwrt.org>,
        "'John Crispin'" <blogic@openwrt.org>,
        "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>
Cc:     <linux-mips@linux-mips.org>, <linux-usb@vger.kernel.org>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name> <1362176257-2328-3-git-send-email-svetoslav@neykov.name> <87r4izivgp.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87r4izivgp.fsf@ashishki-desk.ger.corp.intel.com>
Subject: RE: [PATCH v2 2/2] usb: chipidea: AR933x platform support for the chipidea driver
Date:   Fri, 29 Mar 2013 00:23:37 +0200
Message-ID: <023b01ce2c02$e5faf8f0$b1f0ead0$@neykov.name>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
thread-index: AQJ6crEKrmvOIJbIiJ7dXEbCRe8hgQLMihrRAnv5uNiXONoL4A==
Content-Language: bg
X-Gm-Message-State: ALoCoQktCsz9zxjmPP6b/sfajyxxgZG421pmXutwBhV1Za9FdQrU1bNzRX0ThCQbrWYBm/qn+jIS
X-archive-position: 35991
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
>No need to initialize it like this, it should save a few bytes in
>.data.
Ok.

>Why can't you just use ci13xxx_platform_data?
>It looks like you don't need a glue driver is drivers/usb/chipidea at
>all, you can register ci_hdrc right from the ath79/dev-usb.c

You are right. I will register ci_hdrc in ath79/dev-usb.c.

Regards.
Svetoslav.
