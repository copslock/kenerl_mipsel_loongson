Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2003 01:02:48 +0000 (GMT)
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([IPv6:::ffff:24.221.190.179]:45762
	"EHLO myware.akkadia.org") by linux-mips.org with ESMTP
	id <S8225198AbTAOBCr>; Wed, 15 Jan 2003 01:02:47 +0000
Received: from redhat.com (myware.akkadia.org [192.168.7.70])
	(authenticated bits=0)
	by myware.akkadia.org (8.12.5/8.12.5) with ESMTP id h0F131YA009042;
	Tue, 14 Jan 2003 17:03:02 -0800
Message-ID: <3E24B345.3000408@redhat.com>
Date: Tue, 14 Jan 2003 17:03:01 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guido Guenther <agx@sigxcpu.org>
CC: libc-alpha@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] INTERNAL_SYSCALL for linux-mips
References: <20030114230607.GH27645@bogon.ms20.nix>
In-Reply-To: <20030114230607.GH27645@bogon.ms20.nix>
X-Enigmail-Version: 0.72.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <drepper@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drepper@redhat.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Guido Guenther wrote:
> the attached patch brings mips up to date concerning the
> {INTERNAL,INLINE}_SYSCALL macros.

I've applied the patch.  Thanks,

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JLNF2ijCOnn/RHQRAnPxAKCTNJyDBtLmvZtP7Eq5Zf4d9F2GaQCglf3+
EX9+rGlNZUpvkcIR7aBl14U=
=OVjY
-----END PGP SIGNATURE-----
