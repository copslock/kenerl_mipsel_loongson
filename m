Received:  by oss.sgi.com id <S554264AbRASUEC>;
	Fri, 19 Jan 2001 12:04:02 -0800
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:20033
        "HELO firewall.jaquet.dk") by oss.sgi.com with SMTP
	id <S553664AbRASUDh>; Fri, 19 Jan 2001 12:03:37 -0800
Received: from fixed.jaquet.dk (fixed.intern.jaquet.dk [10.0.0.4])
	by firewall.jaquet.dk (Postfix) with ESMTP
	id 6FDB87622; Fri, 19 Jan 2001 21:03:14 +0100 (CET)
Received: by fixed.jaquet.dk (Postfix, from userid 500)
	id 3C783AF58; Fri, 19 Jan 2001 21:03:13 +0100 (CET)
Date:   Fri, 19 Jan 2001 21:03:13 +0100
From:   Rasmus Andersen <rasmus@jaquet.dk>
To:     K.H.C.vanHouten@kpn.com
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/MIPS Development <linux-mips@oss.sgi.com>,
        K.H.C.vanHouten@research.kpn.com
Subject: Re: [PATCH] make drivers/scsi/dec_esp.c check request_irq return code (240p3) (fwd)
Message-ID: <20010119210313.A622@jaquet.dk>
References: <Pine.LNX.4.05.10101190931310.27117-100000@callisto.of.borg> <200101190840.JAA13979@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200101190840.JAA13979@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Fri, Jan 19, 2001 at 09:40:44AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 19, 2001 at 09:40:44AM +0100, Houten K.H.C. van (Karel) wrote:
> Would this be the cause of the problem I have in my 5000/260
> that I can only use the on-board SCSI interface, and not
> the TC scsi card (which should use the same driver)?

As Florian Lohoff commented I doubt this patch will be of any
help for you. My comment wrt. continuing in the tc loop was
merely in case of a request_irq failure, a failure ignored
earlier. So I would guess that this patch is not your
problemkiller. But testing is always nice :)

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

There are two major products that come out of Berkeley: LSD and UNIX. We 
don't believe this to be a coincidence. -- Jeremy S. Anderson 
