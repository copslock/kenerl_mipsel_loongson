Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MGeEqf002716
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Apr 2002 09:40:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3MGeEtV002715
	for linux-mips-outgoing; Mon, 22 Apr 2002 09:40:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3MGeBqf002690
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 09:40:12 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020422164038.YSTK1143.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Mon, 22 Apr 2002 16:40:38 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 86976125C7; Mon, 22 Apr 2002 09:40:37 -0700 (PDT)
Date: Mon, 22 Apr 2002 09:40:37 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Hartvig Ekner <hartvige@mips.com>
Cc: user alias <linux-mips@oss.sgi.com>
Subject: Re: Problems with H.J's latest RPM 4.0.4 binary packages
Message-ID: <20020422094037.A12357@lucon.org>
References: <200204221446.QAA23835@copsun17.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200204221446.QAA23835@copsun17.mips.com>; from hartvige@mips.com on Mon, Apr 22, 2002 at 04:46:45PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 22, 2002 at 04:46:45PM +0200, Hartvig Ekner wrote:
> I have started to update our 7.1 RH/MIPS installation images with all the
> latest packages from H.J's collection.
> 
> The latest RPM package gives an up-front error no matter what one does, but
> the command seems to work:
> 
> [hartvige@copmalt13 /bin]$ rpm --version
> error: Macro %__id_u has empty body
> RPM version 4.0.4
> [hartvige@copmalt13 /bin]$
> 

I have no problems with the mipsel rpm binary. Did you compile rpm 4.0.4
yourselves? Please send me

# cd /usr/lib/rpm
# grep __id_u * */*

H.J.
