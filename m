Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 20:43:03 +0200 (CEST)
Received: from GS256.SP.CS.CMU.EDU ([128.2.199.27]:64715 "HELO
	gs256.sp.cs.cmu.edu") by linux-mips.org with SMTP
	id <S1122987AbSIQSnC>; Tue, 17 Sep 2002 20:43:02 +0200
Subject: Re: [RFC] FPU context switch
From: justinca@cs.cmu.edu
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20020917110423.E17321@mvista.com>
References: <20020917110423.E17321@mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-r3p6y52323ylrM5yXPYF"
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 14:42:20 -0400
Message-Id: <1032288140.28433.165.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Source-Info: Sender is really justinca+@gs256.sp.cs.cmu.edu
Return-Path: <justinca@cs.cmu.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinca@cs.cmu.edu
Precedence: bulk
X-list: linux-mips


--=-r3p6y52323ylrM5yXPYF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-09-17 at 14:04, Jun Sun wrote:
>=20
> I am rewriting the FPU management code with the following
> objectives in my mind:
>=20
> 1) to make it work for SMP.  Right now, processes can migrate
> to different CPUs leaving their FPU context on another CPU.
> And the global variable last_task_used_math is shared by
> multiple CPUs. :-)
>=20

I took a stab at this for a couple hours a while back, and didn't come
up with anything I liked.   But I may have some insights for you.


> 2) save PFU context when process is switched off *only if*=20
>    FPU is used in the last run. =20
>    restore FPU context on next use of FPU.
>=20
> Need to use an additional flag to remember whether it is used
> in the current run.  Perhaps overridding used_math?  In that
> case, used_math =3D=3D 2 indicates it used in the current run.
> used_math is set back to 1 when process is switched off.
>=20
> Very simply to implement.
>=20
> 3) save FPU context when process is switched off *only if*=20
>    FPU is used in the last run. =20
>    restore FPU context on the next use of FPU and *only* if other=20
>    processes have tampered FPU context since the last use of FPU by=20
>    the current process.
>=20
> This requires each CPU to remember the last owner of FPU.
> In order to support possible process migration cases in a SMP
> system, each process also needs to remember the processor
> on which it used FPU last.  A process has a valid live FPU
> context on a CPU if those two variables match to each other.
> Therefore we can avoid unnecessary restoring FPU context.
>=20
> Fairly complex in implementation.=20
>=20

I'd argue for something between 2 & 3.  Always save FPU state, and if
you know the state has been preserved for the next run, skip the
restore.

I'm a bit leery of the whole "don't restore FPU state on context switch
until you use the FPU again" idea as it's added complexity and I'm not
at all sure you're going to see any measurable performance gain out of
it.  Certainly on an FPU-intensive process this is going to be a loss.

>=20
> 4) don't save or restore any FPU context during context switches.
>    Instead, we implement a full SMP-safe version of lazy fpu=20
>    switch.
>=20
> This introduces three states in terms of FPU context status:
> 	a) live FPU context in current CPU
> 	b) saved FPU context in memory
> 	c) live FPU context in another CPU
> Before we only have a) and b) states.  c) is new in this approach.
>=20
> To deal with c), we need to provide an inter-processor call so that
> we can ask another CPU to save FPU context in case we need to access
> it on this CPU.
>=20
> Additionally we need similar variables required in 3) to keep track
> who owns FPU at any time.
>=20
> Very complex to implement.  Has the best performance, though.
>=20

Just say no.  I doubt this will have the best performance on SMP, just
because the process of getting the state off of the other CPU is going
to be extremely costly.  I'd rather see #1 just for simplicity's sake
before #4...

> Currently I am leaning towards 2) or 3).  What is your opinion?
>=20

Something quick and dirty that I ended up doing recently was to bind fpu
users to the CPU they we're using at the time of the first FPU fault.=20
The last_task_used_math expansion is straightforward and it seemed to
work pretty well.

-Justin

--=-r3p6y52323ylrM5yXPYF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9h3eM47Lg4cGgb74RAgQMAJ9JIw3BUErlr+0PTD4LFUKff5Gk8ACeO/OO
v8UH6Y4Slqme0tl4S3B0RjQ=
=xBHQ
-----END PGP SIGNATURE-----

--=-r3p6y52323ylrM5yXPYF--
