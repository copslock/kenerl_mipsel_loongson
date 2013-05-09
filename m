Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 23:23:00 +0200 (CEST)
Received: from mail-ea0-f172.google.com ([209.85.215.172]:45213 "EHLO
        mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823763Ab3EIVW7UnntO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 23:22:59 +0200
Received: by mail-ea0-f172.google.com with SMTP id r16so1897528ead.31
        for <linux-mips@linux-mips.org>; Thu, 09 May 2013 14:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-type:content-transfer-encoding
         :x-mailer:thread-index:content-language:x-gm-message-state;
        bh=F5QMS79Tfg7ZX2C1V/xfdczfP89VcUbJSGzAxar4t1Q=;
        b=gR9pUODvZ5JssZ0/biD7yp0kIH2jvwLqtSAdasMQxF+s4SamkBWhH3REhAk9uFoXbH
         /M6NFkIbuCeF6CJVo+6A7VRZWXjg4zEa3kmdIRei74m6pleK7Bx6caQm6fCFdNmXJizu
         GAnWG24+Zht/CUIJA7akRlptUsMxUWN51CuqouJQ5C5ZDauts1oAogjtb8PLZyzy48eg
         ZTvg8ytfk5SLSaiQG6xZF6vcI/4ThTL79AtbslqazZ/jnnVApITyUmTsNqTruSBbRxfK
         xVsJQan0W+KHMmsZZIMYLGi+WEqcGWkRt//Dh47NrsnEsogNlxupjQ9AO4JAKyy8AQXW
         IzqQ==
X-Received: by 10.15.24.72 with SMTP id i48mr12603456eeu.37.1368134573753;
        Thu, 09 May 2013 14:22:53 -0700 (PDT)
Received: from hotrod ([77.70.100.51])
        by mx.google.com with ESMTPSA id n7sm6662062eeo.0.2013.05.09.14.22.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 14:22:52 -0700 (PDT)
From:   "Svetoslav Neykov" <svetoslav@neykov.name>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        "'Alexander Shishkin'" <alexander.shishkin@linux.intel.com>
Cc:     "'Ralf Baechle'" <ralf@linux-mips.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Gabor Juhos'" <juhosg@openwrt.org>,
        "'John Crispin'" <blogic@openwrt.org>,
        "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>,
        <linux-mips@linux-mips.org>, <linux-usb@vger.kernel.org>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name> <1362176257-2328-2-git-send-email-svetoslav@neykov.name> <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com> <5154508B.6050509@pengutronix.de>
In-Reply-To: <5154508B.6050509@pengutronix.de>
Subject: RE: [PATCH v2 1/2] usb: chipidea: big-endian support
Date:   Fri, 10 May 2013 00:22:41 +0300
Message-ID: <013d01ce4cfb$5830ab90$089202b0$@neykov.name>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
thread-index: AQJ6crEKrmvOIJbIiJ7dXEbCRe8hgQIpA3+vAboxlnUDZ7H99pdqtydg
Content-language: bg
X-Gm-Message-State: ALoCoQm/BnFtgHa+ITWpiJSgwt5WHaR15liYOoj+WIsl3Q/puTSRJs+xlLjxCMgCT7296IzETrea
Return-Path: <svetoslav@neykov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36371
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

Hi Marc,

Marc Kleine-Budde [mailto:mkl@pengutronix.de] (On Thursday, March 28, 2013
4:16 PM)
>On 03/28/2013 10:28 AM, Alexander Shishkin wrote:
>> Svetoslav Neykov <svetoslav@neykov.name> writes:
>> 
>>> Convert between big-endian and little-endian format when accessing
>>> the usb controller structures which are little-endian by
>>> specification. Fix cases where the little-endian memory layout is
>>> taken for granted. The patch doesn't have any effect on the already
>>> supported little-endian architectures.
>
>Has anyone tested how the cpu_to_le32 and vice versa effects the
>load/store operations? Does the compiler generate full 32 bit accesses
>on mips (and big endian arm) or is a byte-shift-or pattern used?

Better late than never... I have checked your question, the value is loaded
in a register and then swapped, so the read is performed only once.

Regards,
Svetoslav.
