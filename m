Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2006 15:39:56 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:47353 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133530AbWGHOjp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Jul 2006 15:39:45 +0100
Received: by ug-out-1314.google.com with SMTP id k3so2904329ugf
        for <linux-mips@linux-mips.org>; Sat, 08 Jul 2006 07:39:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=loFzxgB9Tc14mskH5WnUvVq7D7YQH+670us6Ggw9Iz/tIb4itS9i+kPTx8sOaHa+SU8pzfow5ctB8NKxAPFKj0kAZjRASuC3Q5ItWyIIsngLKYLoetBDPIQ2+AoUDuOwW9X6NqrY1ZgoIdvhAcjdG25/2LZEJnXFF3Pwb0BRFLY=
Received: by 10.66.219.11 with SMTP id r11mr3096539ugg;
        Sat, 08 Jul 2006 07:39:44 -0700 (PDT)
Received: by 10.67.100.10 with HTTP; Sat, 8 Jul 2006 07:39:44 -0700 (PDT)
Message-ID: <cda58cb80607080739i772d439dqc4e06a8b275e03ee@mail.gmail.com>
Date:	Sat, 8 Jul 2006 16:39:44 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] do not count pages in holes with sparsemem
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20060707.002602.75184460.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060706.233634.59465089.anemo@mba.ocn.ne.jp>
	 <44AD2537.1030509@innova-card.com>
	 <cda58cb80607060805yc656114p53516b904188c20f@mail.gmail.com>
	 <20060707.002602.75184460.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/7/6, Atsushi Nemoto <anemo@mba.ocn.ne.jp>:
> On Thu, 6 Jul 2006 17:05:35 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > >         free_area_init_node(0, NODE_DATA(0), zones_size, 0, zholes_size);
> > > +#else
> > > +       free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET, NULL);
> >
> > which is equivalent to:
> >
> >        free_area_init(zones_size);
>
> Sure.  Then this can be a final proposal?
>

Sorry for the late answer.

Did you check that show_mem() still works ? I'm not sure about that point.

Thanks
-- 
               Franck
