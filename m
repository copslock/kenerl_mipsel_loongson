Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 18:07:47 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:65127 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20027665AbWJKRHp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 18:07:45 +0100
Received: by ug-out-1314.google.com with SMTP id 40so159775uga
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2006 10:07:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lnQw3od+upAc+ip386oRiiA8dWd6DkW/g4k3NK3CBdHzqINVJAFVWsR3PhIo7BHvCAYcBp5GLE6l6sB5VjaZOgmSMUA/8ZzZIA+pxtLdk8L3yL8GpNH6kqDPVUFdjRxqs3ywxLUIL5H+om9JF4jIuNWxVXoNBOvZMdsosFEARFo=
Received: by 10.78.165.16 with SMTP id n16mr1051640hue;
        Wed, 11 Oct 2006 10:07:44 -0700 (PDT)
Received: by 10.78.123.2 with HTTP; Wed, 11 Oct 2006 10:07:44 -0700 (PDT)
Message-ID: <cda58cb80610111007v5bd0b483s5cabe5e1a8638136@mail.gmail.com>
Date:	Wed, 11 Oct 2006 19:07:44 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/5] Make __pa() uses CPHYSADDR() if really needed
Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org
In-Reply-To: <452D1567.1050706@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11605685251014-git-send-email-fbuihuu@gmail.com>
	 <20061011.223352.126573442.anemo@mba.ocn.ne.jp>
	 <452CFC95.1080806@innova-card.com>
	 <20061012.003007.08076055.anemo@mba.ocn.ne.jp>
	 <452D1567.1050706@innova-card.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 10/11/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Atsushi Nemoto wrote:
> > Here's my understanding.
> >
> > CPHYSADDR --- used to convert a CKSEG0 or CKSEG1 to a physical
> > address.  Be carefull when use it in 64-bit kernel.
> >
> > __pa() --- inverse of __va(), of course :-) used to convert a kernel
> > linear logical address to a physycal address.
> >
> > virt_to_phys() --- synonym of __pa() ?
>
> Well in my understanding __pa() is used during bootmem init. It deals with
> initialisation issues and ugliness and that's what CPHYSADDR() actually
> does. virt_to_phys() is used once everything is correctly setup.
>
> > __pa() is used in many place indirectly via virt_to_page().
> >
>
> what about make virt_to_page() use virt_to_phys() instead ?
>

Actually that would make sense. virt_to_page() returns a page which
means that all kernel allocation machinery is setup. It should be safe
to use phys_to_virt() at that time.

-- 
               Franck
