Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 00:10:46 +0200 (CEST)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:54566 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854846AbaEUWKnM0M4J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 May 2014 00:10:43 +0200
Received: by mail-wg0-f48.google.com with SMTP id b13so2607755wgh.19
        for <linux-mips@linux-mips.org>; Wed, 21 May 2014 15:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=d7ggZoxR/DfstozaGrS80Ew+v9cRzcnTpwqb1zDcD10=;
        b=WuZHV/yB/kD+fG+E2OdZx+HWp0pFbs95BB9OcV9Mpz3EFmqeerh36paVdWLiq8/8XS
         poYPXiKXeGHgDlOx94UeO8E6BYB+oI9zMe9QR1pOkTl/EDF2KO5VpaZ5hO4W7oifPIP2
         NZ2v3Ym7kKxhPM0rcNqgTQLlMTDGOaMZkHp05OiA9yCBLcdzZb/035YreTiPP+Y9xlWK
         mubbq0vGTBI63kfInR7MoXhte1luh8u5ebUJhCM8VfIIhJYWF1VKtHorISOmzijf2A4Q
         qPT5i88+sA4aG4yVarS9dCBX0Mjz8zw2U8bPYQ53RJeDQrnNrh5vnmTXFv86zg/4hc2c
         G2RA==
X-Gm-Message-State: ALoCoQn5eor0UN2TdEi+oZ6GYCsSmAPUETc8XvIoSXTxMSsLR6E+ern6Hgr2FEeosoxL4qP9NtYc
X-Received: by 10.194.62.176 with SMTP id z16mr4808532wjr.76.1400710237666;
        Wed, 21 May 2014 15:10:37 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id ej2sm24166947wjd.21.2014.05.21.15.10.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 15:10:36 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Moore <pmoore@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 3.15] MIPS: Add new AUDIT_ARCH token for the N32 ABI on MIPS64
Date:   Wed, 21 May 2014 23:10:27 +0100
Message-ID: <1694165.itQDzbHNHb@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.12.5 (Linux/3.15.0-rc5+; KDE/4.12.5; x86_64; ; )
In-Reply-To: <1683789.b73kOmCp2z@sifl>
References: <1397550996-14805-1-git-send-email-markos.chandras@imgtec.com> <2398159.J868kTHAKn@sifl> <1683789.b73kOmCp2z@sifl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2871445.J1gy5gfS4s"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40231
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


--nextPart2871445.J1gy5gfS4s
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 21 May 2014 16:59:22 Paul Moore wrote:
> On Monday, May 12, 2014 02:53:05 PM Paul Moore wrote:
> > On Tuesday, April 22, 2014 03:40:36 PM Markos Chandras wrote:
> > > A MIPS64 kernel may support ELF files for all 3 MIPS ABIs
> > > (O32, N32, N64). Furthermore, the AUDIT_ARCH_MIPS{,EL}64 token
> > > does not provide enough information about the ABI for the 64-bit
> > > process. As a result of which, userland needs to use complex
> > > seccomp filters to decide whether a syscall belongs to the o32 or n32
> > > or n64 ABI. Therefore, a new arch token for MIPS64/n32 is added so it
> > > can be used by seccomp to explicitely set syscall filters for this ABI.
> > > 
> > > Link: http://sourceforge.net/p/libseccomp/mailman/message/32239040/
> > > Cc: Andy Lutomirski <luto@amacapital.net>
> > > Cc: Eric Paris <eparis@redhat.com>
> > > Cc: Paul Moore <pmoore@redhat.com>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > > ---
> > > Ralf, can we please have this in 3.15 (Assuming it's ACK'd)?
> > > 
> > > Thanks a lot!
> > > ---
> > > 
> > >  arch/mips/include/asm/syscall.h |  2 ++
> > >  include/uapi/linux/audit.h      | 12 ++++++++++++
> > >  2 files changed, 14 insertions(+)
> > 
> > [NOTE: Adding lkml to the To line to hopefully spur discussion/acceptance
> > as this *really* should be in 3.15]
> > 
> > I'm re-replying to this patch and adding lkml to the To line because I
> > believe it is very important we get this patch into 3.15.  For those who
> > don't follow the MIPS architecture very closely, the upcoming 3.15 is the
> > first release to include support for seccomp filters, the latest
> > generation
> > of syscall filtering which used a BPF based filter language.  For reason
> > that are easy to understand, the syscall filters are ABI specific (e.g.
> > syscall tables, word length, endianness) and those generating syscall
> > filters in userspace (e.g. libseccomp) need to take great care to ensure
> > that the generated filters take the ABI into account and fail safely in
> > the
> > case where a different ABI is used (e.g. x86, x86_64, x32).
> > 
> > The patch below corrects, what is IMHO, an omission in the original MIPS
> > seccomp filter patch, allowing userspace to easily separate MIPS and
> > MIPS64. Without this patch we will be forced to handle MIPS/MIPS64 like
> > we handle x86_64/x32 which is a royal pain and not something I want to
> > have deal with again.
> > 
> > Further, while I don't want to speak for the audit folks, it is my
> > understanding that they want this patch for similar reasons.
> > 
> > Please merge this patch for 3.15 or at least provide some feedback as to
> > why this isn't a viable solution for upstream.  Once 3.15 ships, fixing
> > this will require breaking the MIPS ABI which isn't something any of us
> > want.
> > 
> > Thanks,
> > -Paul
> 
> *Bump*
> 
> I don't know what else needs to be done to get some action on this and we're
> running out of time for 3.15.

It was merged yesterday:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c7d6891a770aa97dd36c2df3545031e64c6a0ef3

Cheers
James
--nextPart2871445.J1gy5gfS4s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTfSRaAAoJEGwLaZPeOHZ6c54P/1t5J9KmkWuVSaVQzCAduSCK
mLqTDXmn/D/r0nFIPZZLIYu+eZvHoFugQtntv0b6jR+HB/dqBuP66H+Ii87j1zp1
Hj6dM0yFh2+UeQK+auD4U4WnZkwxOPU3ubOLH9f7EUZ6MoUgydqNSUMoMWdJQVgH
vgx0l63Vt/vIiwg2vvD3vtPZlBDhwwUfAjc0uQZ+dAN0+c0JLmPd88yNna3Rgcb3
wnV3twmwe6vYXr+yJoH4aui4AaJ6GYMfuCAD2nv45Qi1Q54C3chwEfGf9+9xkYOt
XH1Kje08B4yXWzryXbivGmBlH9juzp4jOyzokYdBK3nAHRzsY1TllpQCMwHl/U8V
gCrNlsLIfQeL8pxuFtmwvRyO495y1CaiykBULB2CTqbhulI1lZU6fNmtJBD7t1dF
5PFAW23nSmaGYjJ5rD0wZVP2NyNl+80mBsv/qzwkiG9rE3je3PK2awb6fEJ82CI4
L+1/p6ymMQzBodabsCMjdRNIf2VnjzrM645ZeD2jjDv4FeWQH/Tc9AYjyEf9SqIY
PXZsoCfupebaf6dITzCwHJSSVtXLdG9pHwK4ofm36Uta9tOh019jAWfo+bseou31
DBMF8TQssmn82qYTOlY/JegfAmlt3UcQBUIpl2vyxhoAqk9JyckNtRpX2YW5J5E7
CZ3E9/HYg79Xbwzp6G1e
=DcX3
-----END PGP SIGNATURE-----

--nextPart2871445.J1gy5gfS4s--
