Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 15:23:10 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:37020 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010430AbbGHNXJLSbUC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 15:23:09 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 2732928EF9;
        Wed,  8 Jul 2015 13:23:03 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id F1BDD28EF8;
        Wed,  8 Jul 2015 13:23:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1436361783; bh=d11g5zz9OatcQXuEJTbm0pCbFxylyvltnNy9/SCYESg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgIvIKv9Oo4wLL9RsnnfRL5h6RxV6AZCA+IMe6UQV6uljzby2Ypa9IElAC7yJI5fZ
         UW57b+Pc115OAFvwduD8zynOYQytK2S/XqWpFWWv0x+ugESRgQMqpC+/0NLqzJYBpR
         NjjtOnpnWsgjFTop16+gvf6peOoHqhLEtpYqyp+Q=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id E7E3380085;
        Wed,  8 Jul 2015 13:23:02 +0000 (GMT)
Date:   Wed, 8 Jul 2015 09:23:02 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V3 0/5] Allow user to request memory to be locked on page
 fault
Message-ID: <20150708132302.GB4669@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <20150707141613.f945c98279dcb71c9743d5f2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20150707141613.f945c98279dcb71c9743d5f2@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emunson@akamai.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 07 Jul 2015, Andrew Morton wrote:

> On Tue,  7 Jul 2015 13:03:38 -0400 Eric B Munson <emunson@akamai.com> wro=
te:
>=20
> > mlock() allows a user to control page out of program memory, but this
> > comes at the cost of faulting in the entire mapping when it is
> > allocated.  For large mappings where the entire area is not necessary
> > this is not ideal.  Instead of forcing all locked pages to be present
> > when they are allocated, this set creates a middle ground.  Pages are
> > marked to be placed on the unevictable LRU (locked) when they are first
> > used, but they are not faulted in by the mlock call.
> >=20
> > This series introduces a new mlock() system call that takes a flags
> > argument along with the start address and size.  This flags argument
> > gives the caller the ability to request memory be locked in the
> > traditional way, or to be locked after the page is faulted in.  New
> > calls are added for munlock() and munlockall() which give the called a
> > way to specify which flags are supposed to be cleared.  A new MCL flag
> > is added to mirror the lock on fault behavior from mlock() in
> > mlockall().  Finally, a flag for mmap() is added that allows a user to
> > specify that the covered are should not be paged out, but only after the
> > memory has been used the first time.
>=20
> Thanks for sticking with this.  Adding new syscalls is a bit of a
> hassle but I do think we end up with a better interface - the existing
> mlock/munlock/mlockall interfaces just aren't appropriate for these
> things.
>=20
> I don't know whether these syscalls should be documented via new
> manpages, or if we should instead add them to the existing
> mlock/munlock/mlockall manpages.  Michael, could you please advise?
>=20

Thanks for adding the series.  I owe you several updates (getting the
new syscall right for all architectures and a set of tests for the new
syscalls).  Would you prefer a new pair of patches or I update this set?

Eric

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnSQ2AAoJELbVsDOpoOa9jHcP/RLEmYajmHZ/hRFflieosbLl
xfDDa3xIpZh7VCBCdjAu96XR7jc5Af66dF7GpeB2Vqv/PAI739slpzUqyaXSdEK9
1HpgGkjAHYagYa/BSLRpmDCYKGph2zWsKEUK0xrCaRKbAwytEk2rw863ZoFHM4tv
sftQYCqhB5bkdEQuVu4Hl9D7k9CnrshKl5rURSe+Ub5nj44W47IUyjFugRDi1eRO
WbddZd8e9av7Qte7l1rtQMxch/L4WM5LICujQx9FrNiz0Cb/flG6v3JvW1G50fym
NINBwp64GAbE4jYxpvn5zvIHc9IU8G1As6B7tcXTBzPnjx1zQQuxP7pTmpVoAsVQ
dhJndlDWt3RhdcPz2QDtd9EbUvDdyeLmeyWciB1cx7CZbxnwzqiSXMVzswEqbXiq
RPTEON/PJ3IsyeQ1Pi/Ygnf/LQVwQtYAut+fZZKUIEofARkUGf6V2ReWDdrBB2t5
zdOL4Qgr+GNGpaPqp3kr+vcF7ouIFa7ldH7OblI9yqQHufVFX8slDLtial6j4xXa
D6oU0KUJCjusSpSTbm+KxFPuaC1O+v4lit/GoMvIcdFC6CS5a/hZK+e1QNfOFCh3
uwVDY1DpI0Qq4ESNAFgjyf/HgiKZUPwvTy5zeq42esGbvhBHgIl62NCrk96JYCoO
nkBCH/HT50sOYD+mO/s8
=+7yp
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
