Received:  by oss.sgi.com id <S554162AbRBET5i>;
	Mon, 5 Feb 2001 11:57:38 -0800
Received: from sgigate.SGI.COM ([204.94.209.1]:41517 "EHLO dea.waldorf-gmbh.de")
	by oss.sgi.com with ESMTP id <S554129AbRBET5K>;
	Mon, 5 Feb 2001 11:57:10 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f15JoQo02975;
	Mon, 5 Feb 2001 11:50:26 -0800
Date:   Mon, 5 Feb 2001 11:50:26 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Quinn Jensen <jensenq@Lineo.COM>, linux-mips@oss.sgi.com
Subject: Re: NFS root with cache on
Message-ID: <20010205115026.C2487@bacchus.dhis.org>
References: <3A79C869.2040001@Lineo.COM> <20010204194451.A26868@bacchus.dhis.org> <3A7ED9EB.6080801@Lineo.COM> <3A7EEBD6.F4743A97@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A7EEBD6.F4743A97@mvista.com>; from jsun@mvista.com on Mon, Feb 05, 2001 at 10:07:18AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Feb 05, 2001 at 10:07:18AM -0800, Jun Sun wrote:

> Did you set rx_copybreak to 1518?  I sent patches long time ago to the driver
> authors for MIPS, but I am not sure they are not there.

Copybreak is just an optimization.  So even with this unused or set to a
wrong value the driver should work.

  Ralf
