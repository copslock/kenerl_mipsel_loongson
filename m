Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 11:03:56 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.170]:14008 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037868AbWLALDz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 11:03:55 +0000
Received: by ug-out-1314.google.com with SMTP id 40so2580110uga
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 03:03:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r27rTY33VktGd72AYvDQ9VKenKKzqUtLuy5GgMyd0XjsdsqGyQDCZx2uP4SSojFr5O3w8vpSqX9p7lAFll8Fe7xMikyjO928EbL+Lbl+Hlc3kTkXsYoHxaAixtNbV0Ei09l2xB/4YubcVoSkz5AdkX/tTC5MgsZm4S399Q18Gdk=
Received: by 10.78.185.7 with SMTP id i7mr4679654huf.1164971034538;
        Fri, 01 Dec 2006 03:03:54 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 03:03:54 -0800 (PST)
Message-ID: <cda58cb80612010303x2bedf5betb11959158b292965@mail.gmail.com>
Date:	Fri, 1 Dec 2006 12:03:54 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: Is _do_IRQ() not needed anymore ?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061201.194102.89066483.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80612010206r51d319a1x72105981d900068a@mail.gmail.com>
	 <20061201.191049.63741937.nemoto@toshiba-tops.co.jp>
	 <cda58cb80612010219p50334a6cj4a797dcd608376ed@mail.gmail.com>
	 <20061201.194102.89066483.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/1/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> Also, if you selected GENERIC_HARDIRQS_NO__DO_IRQ, you can remove .end
> handler.  But adding "#ifdef GENERIC_HARDIRQS_NO__DO_IRQ" for each
> .end might be slightly ugly...
>

why not simply removing it since it won't be used anymore ?

-- 
               Franck
