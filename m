Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HGqYnC026022
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 09:52:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HGqYY2026021
	for linux-mips-outgoing; Mon, 17 Jun 2002 09:52:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HGqUnC026018
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 09:52:31 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17Jzky-000aPg-00
	for linux-mips@oss.sgi.com; Mon, 17 Jun 2002 18:53:32 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17Jzmc-0004pJ-00
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 18:55:14 +0200
Date: Mon, 17 Jun 2002 18:55:14 +0200
To: linux-mips@oss.sgi.com
Subject: Re: Code error - why?
Message-ID: <20020617165514.GF8626@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020617094851.30730.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020617094851.30730.qmail@email.com>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Balakrishnan Ananthanarayanan wrote:
[snip]
>          la $a0, quest
>          li $v0, 4
>          syscall   "
>        
> The error messages are:
>   " Hello.S line 5: illegal operands 'la' 
>     Hello.S line 6: illegal operands 'li'"
> 
> Can anyone help? What is wrong?

The register names are wrong. The software names, if defined in some
assembler header, are 'a0' and 'v0', while the assembler recognized
hardware names are '$4' and '$2'.


Thiemo
