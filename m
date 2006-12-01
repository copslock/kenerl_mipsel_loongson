Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:40:43 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.238]:51019 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038423AbWLAPkj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 15:40:39 +0000
Received: by wr-out-0506.google.com with SMTP id i32so937481wra
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 07:40:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K/iX8tITw9zCT6xfR5qGOoSUe/HjcAx2wQHeRJX8zbkK3YbZqgfCNxgAkzODi8OfOwNlMgymlYZTrgQFTecWHVhENiqU+dSmsbM2N3NQ3WLA1+Aq8C+f/AaHuTiyrVBe+oWqKknmCZ3Mwx2Cp84g7MBzGBrbLfIroB1XUIqNb9M=
Received: by 10.78.149.15 with SMTP id w15mr4921584hud.1164987637295;
        Fri, 01 Dec 2006 07:40:37 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 07:40:37 -0800 (PST)
Message-ID: <cda58cb80612010740u50bf6a7an78e735db0a9c9168@mail.gmail.com>
Date:	Fri, 1 Dec 2006 16:40:37 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] Compile __do_IRQ() when really needed [take #2]
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.64N.0612011535090.5923@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45704B26.9040202@innova-card.com>
	 <Pine.LNX.4.64N.0612011535090.5923@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/1/06, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>
>  Well, end_ioasic_irq() is called from end_ioasic_dma_irq(), sorry. ;-)
>

no problem, I should had caught this by my own. Let's do it again...

thanks
-- 
               Franck
