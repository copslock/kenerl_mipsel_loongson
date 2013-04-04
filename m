Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Apr 2013 10:23:54 +0200 (CEST)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:63262 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823043Ab3DDIXwdQ-Ic (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Apr 2013 10:23:52 +0200
Received: by mail-wg0-f49.google.com with SMTP id e11so2500224wgh.16
        for <linux-mips@linux-mips.org>; Thu, 04 Apr 2013 01:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-type:content-transfer-encoding
         :x-mailer:thread-index:content-language:x-gm-message-state;
        bh=wAKCDUraVGtiJg1bymT/BZoy4gnk+ZCGnk/eQannUoI=;
        b=GRQTdWlArX6rVZ2HwASx03b5VL4WgXEB0M07GvlRY0+WGLYmhp8LfpnDjEgFBXNgQF
         Dj4n9qNHNqpGtfsiY/CUyq3JVNuDi2SAsqQDMVYUf4pE7ebcLFASvaxGdOel6hrhFgO9
         nWavNY/oXppqP4arDqawxTqAGGzut4Hum93zz76IxAG7UWbb+CYIU6xhWqAp+bKElQb7
         O7zDeSPHmfwOKQMzHW6b45Z15ri6G+gZukqM9iEwB4fMBw1c9ydhH5nnHkAfFG8zHBi1
         VLDGvXa3a64iqCgMY6n+d5JxybfvzvaGF60T4tURMbsgnHCpIRYGbtK+Y+cZJ1gZUoLF
         MPwA==
X-Received: by 10.194.219.162 with SMTP id pp2mr7864704wjc.27.1365063826920;
        Thu, 04 Apr 2013 01:23:46 -0700 (PDT)
Received: from hotrod ([77.70.100.51])
        by mx.google.com with ESMTPS id bk1sm14378980wib.2.2013.04.04.01.23.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 01:23:45 -0700 (PDT)
From:   "Svetoslav Neykov" <svetoslav@neykov.name>
To:     "'Alexander Shishkin'" <alexander.shishkin@linux.intel.com>,
        <linux-mips@linux-mips.org>, <linux-usb@vger.kernel.org>
Cc:     "'Ralf Baechle'" <ralf@linux-mips.org>,
        "'Gabor Juhos'" <juhosg@openwrt.org>,
        "'John Crispin'" <blogic@openwrt.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>
References: <1365026686-4131-1-git-send-email-svetoslav@neykov.name> <87zjxeentl.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87zjxeentl.fsf@ashishki-desk.ger.corp.intel.com>
Subject: RE: [PATCH v3 0/1] Chipidea driver support for the AR933x platform
Date:   Thu, 4 Apr 2013 11:23:39 +0300
Message-ID: <0b0301ce310d$b739afb0$25ad0f10$@neykov.name>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
thread-index: AQGKYmTpW85It6a8WwOQ0c9V5qPAfQHX6FHGmT6Vu4A=
Content-Language: bg
X-Gm-Message-State: ALoCoQkKHyKPyJ+niFHOIZjs7OhBWpka1GNBOI30TcyVsZMRHYlYcMuG7yBJ8O4JttR24aewGkdA
Return-Path: <svetoslav@neykov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36012
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

From: Alexander Shishkin [mailto:alexander.shishkin@linux.intel.com] 
>Svetoslav Neykov <svetoslav@neykov.name> writes:
>
>> Add support for the usb controller in AR933x platform.
>> The controller supports both host or device mode (defined at startup) 
>> but not OTG. 
>> The patches are tested on WR703n router running OpenWRT in device mode.
>
>You forgot to mention the dependencies, dr_mode in usb core and dr_mode
>in ci13xxx_platform_data, which are not there yet.

Yes, you are right, I forgot to state it explicitly.

Thanks,
Svetoslav.
