Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 17:16:11 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.241]:58413 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20038436AbWLGRQE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 17:16:04 +0000
Received: by an-out-0708.google.com with SMTP id c8so69723ana
        for <linux-mips@linux-mips.org>; Thu, 07 Dec 2006 09:16:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MTk3b8oPcPhaqfg5qL08abcsYAZpLfpAMVtfAjmSojC82IPmoR55cblCSXlNTYHgxKbBw5f8+OydwVj0RBbyBma4fHo8njMUBRaaukiB0B5ek/rvOHmHkq7DPBGMrplU/BooielzLPBMUnCyxJKikax0OXdkN+e/CeVFY2RXCqs=
Received: by 10.78.183.15 with SMTP id g15mr1563236huf.1165511762418;
        Thu, 07 Dec 2006 09:16:02 -0800 (PST)
Received: by 10.78.123.2 with HTTP; Thu, 7 Dec 2006 09:16:01 -0800 (PST)
Message-ID: <cda58cb80612070916l259dd1a9xed6643bd2cdf6e8a@mail.gmail.com>
Date:	Thu, 7 Dec 2006 18:16:01 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] add GENERIC_HARDIRQS_NO__DO_IRQ for i8259 users
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20061208.015507.82088245.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061208.015507.82088245.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/7/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Now i8259A_chip uses new irq flow handler.  Select
> GENERIC_HARDIRQS_NO__DO_IRQ on some more platforms.
>

Looks good to me.

thanks
-- 
               Franck
