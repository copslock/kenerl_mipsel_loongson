Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2002 02:42:59 +0200 (CEST)
Received: from 12-234-207-60.client.attbi.com ([12.234.207.60]:64679 "HELO
	gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S1122166AbSISAm7>; Thu, 19 Sep 2002 02:42:59 +0200
Received: (qmail 14316 invoked by uid 502); 19 Sep 2002 00:42:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Sep 2002 00:42:49 -0000
Date: Wed, 18 Sep 2002 17:42:42 -0700 (PDT)
From: ilya@theIlya.com
X-X-Sender: ilya@ns2.total-knowledge.com
To: Brian Murphy <brian@murphy.dk>
cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: 2.5 pci
In-Reply-To: <3D88EAE6.50909@murphy.dk>
Message-ID: <Pine.LNX.4.44.0209181740090.11585-100000@ns2.total-knowledge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ilya@theIlya.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

put in your board pci initalization file
subsys_initcall(pcibios_init);

(outside of any function)

On Wed, 18 Sep 2002, Brian Murphy wrote:

> Can anybody tell me how pcibios_init is supposed to get called in the
> 2.5 kernel?
> I had to add it back to pci_init (pci.c) to make it detect my pci devices.
>
> /Brian
>
>
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: pgpenvelope 2.9.0 - http://pgpenvelope.sourceforge.net/

iD8DBQE9iR2J84S94bALfyURAvB9AJ91qL6qWwGj4ndoKqEEWHcPz7afqQCggOCR
QAw/eiRCTh9pv3MPuEP/5BE=
=NKQn
-----END PGP SIGNATURE-----
