Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f783xcC16316
	for linux-mips-outgoing; Tue, 7 Aug 2001 20:59:38 -0700
Received: from gateway.total-knowledge.com (c1213523-b.smateo1.sfba.home.com [24.1.66.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f783xZV16312
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 20:59:36 -0700
Received: (qmail 17737 invoked by uid 502); 8 Aug 2001 03:59:34 -0000
Content-Type: text/plain;
  charset="koi8-r"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total knowledge
To: "Steven Liu" <stevenliu@psdc.com>, <linux-mips@oss.sgi.com>
Subject: Re: execve("sbin/init",argv_init,envp-init) in init() of main.c and sbin/init.
Date: Tue, 7 Aug 2001 20:59:31 -0700
X-Mailer: KMail [version 1.2]
Cc: <dankamura@mvista.com>
References: <84CE342693F11946B9F54B18C1AB837B0A2294@ex2k.pcs.psdc.com>
In-Reply-To: <84CE342693F11946B9F54B18C1AB837B0A2294@ex2k.pcs.psdc.com>
MIME-Version: 1.0
Message-Id: <01080720593103.03147@gateway>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Look for SystemVinit at sunsite.unc.edu, or any other major free software archive.
Or just search alte vista...
On Tuesday 07 August 2001 17:36, Steven Liu wrote:
> Hi, ALL:
>
> I posted a message in this board regarding
> execve("sbin/init",argv_init,envp-init) in init() of main.c this
> morning. Pete gave some very good suggessions.Thank you very much, Pete.
> I tried them but the problem has not been solved yet. My CPU is not
> standard R3000 mips CPU with some registers added in and modified. For
> example, ASID field in EntryHi register is of 8 bits instead of 6 bits.
> This may creat some problems.
>
> I want to investigate the "sbin/init" program but I do not know where I
> can find the source code of this program. If you know any hint and let
> me know, I would be very pleased.
>
> Thank you for your help.
>
> Regards,
>
> Steven Liu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtwuSYACgkQtKh84cA8u2nn7gCeNd3zrFk3mPAzKubwGfW3EVEC
Cq4AoIyMVLJ0LSbc/1Iot28eCBSmaVaf
=UyqM
-----END PGP SIGNATURE-----
