Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g55NmknC023922
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 5 Jun 2002 16:48:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g55NmkC4023921
	for linux-mips-outgoing; Wed, 5 Jun 2002 16:48:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gateway.total-knowledge.com (12-236-42-25.client.attbi.com [12.236.42.25])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g55NmgnC023917
	for <linux-mips@oss.sgi.com>; Wed, 5 Jun 2002 16:48:42 -0700
Received: (qmail 7896 invoked by uid 502); 5 Jun 2002 23:50:41 -0000
Message-ID: <20020605235041.7895.qmail@gateway.total-knowledge.com>
Content-Type: text/plain;
  charset="koi8-r"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total Knowledge
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, nick@snowman.net
Subject: Re: 3 questions about linux-2.4.18 and R3000
Date: Wed, 5 Jun 2002 16:50:36 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-mips@oss.sgi.com
References: <20020603235311.GJ23411@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.21.0206041341130.31816-100000@ns> <20020605223736.GN23411@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20020605223736.GN23411@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 05 June 2002 03:37 pm, Thiemo Seufer wrote:
> nick@snowman.net wrote:
> > Do you have gfx working on i2 impact?
>
> Nothing more than the firmware will do.
>
> > Is it also an R10k system, or are
> > you useing an r4k system?
>
> IT's r10k. AFAIH the r4k systems have still ARCS32 and should be
> able to boot a 32 bit kernel.
And how are you dealing with R10K speculative execution
in non-cache-coherent systems problem?

> Thiemo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE8/qPR84S94bALfyURAiG0AKDoaTAi0vHNUpIO3ZRmL1NjLRHgOQCaA/En
/WCTs3jSjNdYBBN5KI8o7VE=
=0QL6
-----END PGP SIGNATURE-----
