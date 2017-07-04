Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2017 18:51:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22616 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993859AbdGDQvhY0rJU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2017 18:51:37 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B2B8F41F8DF5;
        Tue,  4 Jul 2017 19:01:51 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 04 Jul 2017 19:01:51 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 04 Jul 2017 19:01:51 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1EE979A201D41;
        Tue,  4 Jul 2017 17:51:28 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 4 Jul
 2017 17:51:31 +0100
Date:   Tue, 4 Jul 2017 17:51:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/4] MIPS16e2: Provide feature overrides for non-MIPS16
 systems
Message-ID: <20170704165131.GB6973@jhogan-linux.le.imgtec.org>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
 <alpine.DEB.2.00.1705230345530.2590@tp.orcam.me.uk>
 <20170703203250.GN31455@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1707041636350.3339@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QK8nhFMwR+o7J1de"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1707041636350.3339@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--QK8nhFMwR+o7J1de
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 04:50:00PM +0100, Maciej W. Rozycki wrote:
> On Mon, 3 Jul 2017, James Hogan wrote:
>=20
> > > Hardcode the absence of the MIPS16e2 ASE for all the systems that do =
so=20
> > > for the MIPS16 ASE already, providing for code to be optimized away.
> > >=20
> > > Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> >=20
> > I'm inclined to agree with Florian, that git formatted patches are
> > slightly easier to review, perhaps they just subjectively look more
> > familiar. Out of interest, do you not use git for retrieving kernel
> > source already?
>=20
>  I do use GIT for managing the sources themselves of course, however I=20
> keep using `quilt' for patches for two main reasons:
>=20
> 1. It works efficiently for the work flow I've got used to,

fair enough.

> e.g. how do I hand-edit 16th previous diff with GIT;

git rebase -i HEAD~17
You can change a commit from "pick" to "edit" to get the rebase to stop
and allow you to edit the tree at that point in the series, before
continuing with "git rebase --continue" (or --abort to cancel the
rebase).

> how do I swap patches;

git rebase -i $base
and reorder the lines

> how do I move individual hunks between patches? -- these actions are
> trivial with `quilt'.

git rebase -i is again the answer, though probably not as trivial as
quilt (though perhaps more robust than hand editing patches?).

I've found a few ways that generally revolve around using
git checkout -p,

Example 1:
To move a hunk from a later commit into an earlier commit, add

x git checkout -p $later_commit && git commit --amend $earlier_commit

before the later commit in the interactive rebase. Pick the hunks you
want to grab (you can edit them there too), and when rebase is done you
have a fixup commit before the later commit. Finally do another rebase
with --autosquash:

git rebase -i $base --autosquash

to automatically squash the fixup commit into the earlier commit

Example 2:
To move a hunk from an earlier commit into a later commit, you could
"git checkout -p" after both commits, e.g.

pick $earlier_commit
x git checkout -p HEAD~ && git commit --amend
pick $intermediate1
pick $later_commit
x git checkout -p $later_commit && git commit --amend

Interactively undo the change (first checkout -p), and interactively
reapply the change (second checkout -p).

Being git there's 100 variants of that, e.g. changing pick to edit and
doing the commands manually, or doing the same thing as Example 1 for
moving hunks later if you aren't expecting conflicts (but you'll have to
move the fixup yourself as --autosquash doesn't move fixups later).

Its obviously advisable to inspect and diff after rebase -i to double
check.

Cheers
James

--QK8nhFMwR+o7J1de
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllbx4oACgkQbAtpk944
dnrDkw/+LIvww+v+74x7k59ySTZqjz4aTdRh9PMMRu+TsE4nFkmDBSM4tkIAxGjx
ULDGp5/9OxqTtRZWoNQi0geRQDR1/o37H7sAxENlWeUQXwdD+BgaG1/XgCU+z1D0
H25Khj3m1o8zcGodPLdZ9GmX5oqweFaUaY/uOzFbqKZQLpo2FTyG0/TAl/bKgIIT
4ZAcBnn3Qcsaow1avAQQQ44BYVh30pFQfC+prv6G2V57iNp0yhF5QfGqbrjPRmoB
FIIO+Zo2ugswdLd5t2voo4uh23Vysa0oLP2uyq8fEBoruqj86NBH6L9wSgD7b8ti
QMwK06qzEQCq60QgcTfFQr8DfP3Auqi+jmJ9W0G3TnaoFUxyxZVZjRm9BHgwDSXP
uBX7gr1DWmXzKLzDFbZwK6weAUJGuq904ahx8hmn4eYgNZnI1S/MIqChNi1CsbKc
czCVOuFaV7LIkl1Es27g0hygcRJOZFH6Hy35hbgWsgUXJGzZ7zvaGxTgoMlUReZ3
ld5qA2GWEvioSmok+gwHKXCI8clb5vaIfNs92a08Y7H7KszVmr4BQsxIJJgTK92L
3guMwRPuf52Cpq5T3qNq50VYP7O/WMQIBEwmLtanu+8JTNLq2t4B/GFebp38TeyS
0bM+Xzib0f1MG42wP0XmtzUn5X+I7Zd5UrakeXBw56jcAKH88u4=
=+5yr
-----END PGP SIGNATURE-----

--QK8nhFMwR+o7J1de--
