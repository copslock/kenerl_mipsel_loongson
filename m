Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 16:19:20 +0100 (CET)
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:35319 "EHLO
	executor.cambridge.redhat.com") by linux-mips.org with ESMTP
	id <S1122121AbSKEPTS>; Tue, 5 Nov 2002 16:19:18 +0100
Received: from talisman.cambridge.redhat.com (talisman.cambridge.redhat.com [172.16.18.81])
	by executor.cambridge.redhat.com (Postfix) with ESMTP
	id CBD84ABAF8; Tue,  5 Nov 2002 15:19:11 +0000 (GMT)
Received: (from rsandifo@localhost)
	by talisman.cambridge.redhat.com (8.11.6/8.11.0) id gA5FJ5V27022;
	Tue, 5 Nov 2002 15:19:05 GMT
X-Authentication-Warning: talisman.cambridge.redhat.com: rsandifo set sender to rsandifo@redhat.com using -f
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl>
	<3DC68907.30708@realitydiluted.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: 05 Nov 2002 15:19:04 +0000
In-Reply-To: <3DC68907.30708@realitydiluted.com>
Message-ID: <wvnvg3ct57b.fsf@talisman.cambridge.redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"Steven J. Hill" <sjhill@realitydiluted.com> writes:
> In the '_bfd_mips_elf_final_write_processing' function in 'bfd/elfxx-mips.c'
> If I print out the EF_MIPS_ARCH flags for the input BFD descriptor. It
> is properly set to 'MIPS2', but when the case statement in
> '_bfd_mips_elf_final_write_processing' is traversed, it
> uses the R3000/default case which means that the target CPU architecture
> didn't get put into the BFD descriptor.

Is it related to this?

    <http://sources.redhat.com/ml/binutils/2002-10/msg00248.html>

(In the message body, I accidentally copied the code after
the patch rather than before.  Sorry about that.)

Anyway, that patch won't solve your problem, but the issue
seems to be the same: _bfd_mips_elf_merge_private_bfd_data()
merges the EF_MIPS_ARCH and EF_MIPS_MACH bits, but
_bfd_mips_elf_final_write_processing() overwrites them
based on the BFD mach.

Personally, I think _bfd_mips_elf_final_write_processing()
is doing the right thing.  Surely we ought to be able to
set EF_MIPS_ARCH and EF_MIPS_MACH based on the value of
bfd_get_mach?

I wonder whether _bfd_mips_elf_merge_private_bfd_data() should
be checking for compatibility based on the BFD machs rather
than the header flags.  It seems a bit odd that we check the
ISA level and "machine" separately.

In other words, replace:

  /* Compare the ISA's.  */
  if ((new_flags & (EF_MIPS_ARCH | EF_MIPS_MACH))
      != (old_flags & (EF_MIPS_ARCH | EF_MIPS_MACH)))
    {
      ...
    }

with code that checks bfd_get_mach (ibfd) against bfd_get_mach (obfd).
If ibfd's architecture is an extension of obfd's, copy it to obfd.

Richard
