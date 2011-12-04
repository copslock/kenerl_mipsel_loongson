Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2011 22:49:23 +0100 (CET)
Received: from narfation.org ([79.140.41.39]:43628 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903637Ab1LDVtS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 4 Dec 2011 22:49:18 +0100
Received: from sven-laptop.home.narfation.org (i59F6CF54.versanet.de [89.246.207.84])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id 33C9694013;
        Sun,  4 Dec 2011 22:51:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=narfation.org; s=mail;
        t=1323035461; bh=GKM8jeAiRdqqfuG6yco2XIYwCs5CnJh6qUypHqCFVDg=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=Eg1ST5/SDpig76RBNCbl2zf51WC7OpUqsG4Q3UUwixwh2a3btULnIUmYCXLsyIplO
         iXBh8VgZ8AtsZPuC5/H8n/PsSz5SMotEZwtzma+I0EIN3fQAmnWyAnr2/YuFDvVAN7
         AAY1kj83V5fBqJ8a1uC0Yh5p9MArKIDy+FFCrp5w=
From:   Sven Eckelmann <sven@narfation.org>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        Randy Dunlap <rdunlap@xenotime.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergma nn <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org
Subject: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
Date:   Sun, 04 Dec 2011 22:49:10 +0100
Message-ID: <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
User-Agent: KMail/4.6.0 (Linux/3.1.0-1-686-pae; KDE/4.6.5; i686; ; )
In-Reply-To: <20111204213316.GB14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org> <20111204213316.GB14542@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4938203.Qb6ixptZZ3"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
X-archive-position: 32023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sven@narfation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2736


--nextPart4938203.Qb6ixptZZ3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 04 December 2011 21:33:16 Russell King - ARM Linux wrote:
[...]
> > +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> 
> I think this is rather silly - all these definitions are very similar to
> each other.  Is there really no way to put this into include/linux/atomic.h,
> maybe as something like:
> 
> #ifndef atomic64_dec_not_zero
> #define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> #endif
> 
> and avoid having to add essentially the same definition to 12 individual
> files?
> 
> Architectures which want to override it can do by the following:
> 
> #define atomic64_dec_not_zero		atomic64_dec_not_zero
> 
> which won't have any effect on C nor asm code.

 * https://lkml.org/lkml/2011/5/8/15
 * https://lkml.org/lkml/2011/5/8/16
 * https://lkml.org/lkml/2011/5/8/321

Kind regards,
	Sven
--nextPart4938203.Qb6ixptZZ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO2+rWAAoJEF2HCgfBJntGGaoP/1cME9u1tSkxi9MYlM/Ss2sw
Du85XnWWOFnV+CRwZ7+QCkgr10dzf/Qf7ekcxzM/7wapAawu0FmBbehfNW+06uW0
4XrIxUDaZy0xgHusju96MVJav0msORD/2RXM3rQxwkjR2FhmfbVntuIu/5EqEHFv
jIzksziGDgrHx6/HMjrEiX8p2tPPBfQ7MGa1Cvj+kLgDhPAPCOUKfpwgdj35MYHe
2D+zXMr6aHi/JtDkYK2BV9u9nAGx91fcPdOO4/SyyxVg4DLrUnuRgWhNF9UCXd7R
IDkz2SAlkqP5RXKa9XMxnS1n1zjkpmc1wfRL4rPHmk7Fg9IgidnlZ8TsXKuDjoVR
JtIuXmj1FQ5nuHnzKnzhIfHMlu395tL0PVHeWi1+dPZGfUCLX+T4jdlTRaShY3d1
UUzpbfKuc2dy8uX5BNfJ5kQl4PSx8w97Kn+8vRbb3U627FIpdkK8RQNEGgB7wpIR
rCqnxvsjPiiyQA9ckXmL/S0d9xlrPcrB1Tu4kUgXYTr6llV/xKWuYtl801IFP6lr
kFqvPd5St69DP66x5bMMC4NalTEfCIx7HOx+xd3xQC+9qsJVLomz95bvMZHxeI8K
Ae736/5KDqONzVPOKW2J+UJIJLqIZPuSbNVRY9lkTZXjii1U25WY03PGAGwa4LLP
mGvc5Y2WUfdr8CtFrvVL
=T3Oo
-----END PGP SIGNATURE-----

--nextPart4938203.Qb6ixptZZ3--
