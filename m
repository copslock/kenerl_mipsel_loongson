Received:  by oss.sgi.com id <S553802AbRAJAcH>;
	Tue, 9 Jan 2001 16:32:07 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:60654 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553777AbRAJAcA>; Tue, 9 Jan 2001 16:32:00 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867580AbRAJAVm>; Tue, 9 Jan 2001 22:21:42 -0200
Date:	Tue, 9 Jan 2001 22:21:42 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Guido Guenther <guido.guenther@gmx.net>
Cc:	linux-mips@oss.sgi.com
Subject: Re: sgialib.h
Message-ID: <20010109222142.A8077@bacchus.dhis.org>
References: <20010110004305.A6815@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010110004305.A6815@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Wed, Jan 10, 2001 at 12:43:05AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 10, 2001 at 12:43:05AM +0100, Guido Guenther wrote:

> Building of latest cvs kernel for IP22 fails for me in 
> arch/mips/arc/init.c and arch/mips/kernel/setup.c 
> due to a typemismatch in the declaration of prom_init in the above 
> mentioned files and sgialib.h. The attached patch fixes this.

Thanks, applied.

  Ralf
