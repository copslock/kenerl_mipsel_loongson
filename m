Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HIYgI26169
	for linux-mips-outgoing; Thu, 17 Jan 2002 10:34:42 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HIYbP26166
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 10:34:37 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 20776125C1; Thu, 17 Jan 2002 09:34:33 -0800 (PST)
Date: Thu, 17 Jan 2002 09:34:32 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Torsten Weber <t.weber@hhi.de>
Cc: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: -O2 in gcc 2.96 buggy?
Message-ID: <20020117093432.A995@lucon.org>
References: <3C46C2D5.F191DC26@hhi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C46C2D5.F191DC26@hhi.de>; from t.weber@hhi.de on Thu, Jan 17, 2002 at 01:25:57PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 17, 2002 at 01:25:57PM +0100, Torsten Weber wrote:
> On a RedHat 7.1 installation I compiled gawk (3.1.0),  but gawk crashed
> (gawk couldn't run glibc-2.2.4/scripts/firstversions.awk, it resulted
> in:
>        > (FILENAME=- FNR=1) fatal error: internal error
>        > Aborted (core dumped)
> )
> The gawk problem disappeares if I compile without optimizing with -O2
> (i.e. optimizing with -O works).
> 
> gcc version is 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)
> 
> Is this problem already known, or where is my mistake?

I know a kernel bug caused this problem.



H.J.
