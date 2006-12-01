Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 10:06:50 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.169]:47267 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037863AbWLAKGq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 10:06:46 +0000
Received: by ug-out-1314.google.com with SMTP id 40so2566123uga
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 02:06:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UTWwr7qVzA//Fkw7I98lElC4TW82CbAbgR7isMY75OB+w8ripAjP8NvxulQy0jgoAIgn8276FlTW/Vohsyb+ZbBMdoRYroXTapdOzXhg6vlnzbmTtf6E1WkDOzCfsPfep9TGjcqM34HjtNee/fgPI0BBaWnQtjqqT1cZBHBjDSQ=
Received: by 10.78.201.2 with SMTP id y2mr4626608huf.1164967604951;
        Fri, 01 Dec 2006 02:06:44 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 02:06:44 -0800 (PST)
Message-ID: <cda58cb80612010206r51d319a1x72105981d900068a@mail.gmail.com>
Date:	Fri, 1 Dec 2006 11:06:44 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: Is _do_IRQ() not needed anymore ?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061201.185740.03976990.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80612010140y5a95faceybffedbd4dd9900db@mail.gmail.com>
	 <20061201.185740.03976990.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/1/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> No, there are irq chips still need __do_IRQ().  Please grep
> 'set_irq_chip('.
>
> If _all_ irq chip were converted to use flow handler,
> GENERIC_HARDIRQS_NO__DO_IRQ will be good.  But we have i8259...

That's why in my example I made GENERIC_HARDIRQS_NO__DO_IRQ config
default to 'n' and selected by a irq chip that doens't use __do_IRQ()
anymore, well I think...

-- 
               Franck
