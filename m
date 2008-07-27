Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jul 2008 10:10:42 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:26892 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20032836AbYG0JKe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 27 Jul 2008 10:10:34 +0100
Received: by nf-out-0910.google.com with SMTP id h3so1182177nfh.14
        for <linux-mips@linux-mips.org>; Sun, 27 Jul 2008 02:10:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=deEr/bu9+fNEKd0wAw3OILVc+//mi0V0w1eovZ1cwWw=;
        b=o4+iMIUUnCwxQg+tV/32qVBbHqUzwsWGJjLidWuy9f1A3Q5QXDn8lLjk1ZIgOvT1c0
         ZCDOm3WLsdEo9puEN3k5txfQguRQDBsVKt3i0efY+Py/VbI8v6JJmcqnWSj90g1ZxAjc
         7vN+zwbAQxZHWdvZcKLeTb8EtWPjws8QqTXzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=nBOx/9RmMUEgEg1B3SuD9vica+JY2ZldiGSMOy9cwFHzVpJix3MfRFdrgnYnvMYwZE
         9j7qmLTippQBbYjDRmorwT2ORGZgnw0YUABrNrRKtNh9oJdGsnM3AthOQj/TOKHUzsiL
         R6+0z6T9FvQR34Ve7g8V/eUga67WSZzCqnAZY=
Received: by 10.210.122.5 with SMTP id u5mr4279762ebc.73.1217149832865;
        Sun, 27 Jul 2008 02:10:32 -0700 (PDT)
Received: from localhost ( [79.67.114.192])
        by mx.google.com with ESMTPS id j8sm19280667gvb.1.2008.07.27.02.10.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Jul 2008 02:10:31 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	binutils@sourceware.org
Mail-Followup-To: binutils@sourceware.org,gcc@gcc.gnu.org,  linux-mips@linux-mips.org, rdsandiford@googlemail.com
Cc:	gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home>
	<20080724161619.GA18842@caradoc.them.org>
Date:	Sun, 27 Jul 2008 10:10:23 +0100
In-Reply-To: <20080724161619.GA18842@caradoc.them.org> (Daniel Jacobowitz's
	message of "Thu\, 24 Jul 2008 12\:16\:20 -0400")
Message-ID: <87y73nelq8.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz <dan@debian.org> writes:
> All comments welcome - Richard, especially from you.  How would you
> like to proceed?  I think the first step should be to get your other
> binutils/gcc patches merged, including MIPS16 PIC; I used those as a
> base.  But see a few of the notes for potential problems with those
> patches.

Yeah, Nick's approved most of the remaining binutils changes (thanks).
I haven't applied them yet because of the doubt over whether st_size
should be even or odd for ISA-encoded MIPS16 symbols.  I don't really
have an opinion, so I'll accept a maintainerly decision...

Anyway, the gcc patch looks good to me, thanks.  The only niggle
I could see was that you didn't update the comment for:

+/* True if the output file is marked as ".abicalls; .option pic0"
+   (-call_mixed).  This is a GNU extension.  */
+#define TARGET_ABICALLS_PIC0 \
+  (TARGET_ABSOLUTE_ABICALLS && TARGET_PLT)

(That kind of thing was inevitable given the amount of code you had
to wade through.  I'm impressed if there's really only one instance!)
I think the gcc side is good to go, modulo the _mcount thing.

As far as binutils goes, I saw a couple of potential problems:

(1) The patch adds the following code to
    _bfd_mips_elf_create_dynamic_sections:

+      if (htab->use_plts_and_copy_relocs && htab->root.hplt == NULL)
+	{
+	  h = _bfd_elf_define_linkage_sym (abfd, info, s,
+					   "_PROCEDURE_LINKAGE_TABLE_");
+	  htab->root.hplt = h;
+	  if (h == NULL)
+	    return FALSE;
+	  h->type = STT_FUNC;
+	}

    But use_plts_and_copy_relocs is only set after all input bfds have
    been read in.
    
(2) The patch sets pointer_equality_needed as follows:

@@ -7432,9 +7484,18 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 		elf_hash_table (info)->dynobj = dynobj = abfd;
 	      break;
 	    }
-	  /* Fall through  */
+	  /* Fall through.  */
 
 	default:
+	  /* Most static relocations require pointer equality, except
+	     for branches.  */
+	  if (h)
+	    h->pointer_equality_needed = TRUE;
+	  /* Fall through.  */
+
+	case R_MIPS_26:
+	case R_MIPS_PC16:
+	case R_MIPS16_26:
 	  if (h)
 	    ((struct mips_elf_link_hash_entry *) h)->has_static_relocs = TRUE;
 	  break;

    But pointer equality is needed for non-call GOT relocations too.
    I couldn't see anything that explicitly handled that case.

    I think it would be more robust to set pointer_equality_needed in a
    separate block, rather than combining it with the existing switch
    statements.  It might then be clearer to set has_nonpic_branches
    in the new block too, so that you don't need two copies of:

	  if (h && !PIC_OBJECT_P (abfd))
	    ((struct mips_elf_link_hash_entry *) h)->has_nonpic_branches = TRUE;

Some minor nits too:

+  0x03990000,	/* l[wd] $25, %lo(&GOTPLT[0])($28)			*/
+  0x01d90000,	/* l[wd] $25, %lo(&GOTPLT[0])($14)			*/
+  0x01d90000,	/* l[wd] $25, %lo(&GOTPLT[0])($14)			*/

These are all fixed as either lw or ld.

@@ -1649,13 +1695,16 @@ mips_elf_check_symbols (struct mips_elf_
       /* H is a function that might need $25 to be valid on entry.
 	 If we're creating a non-PIC relocatable object, mark H as
 	 being PIC.  If we're creating a non-relocatable object with
-	 non-PIC references to H, make sure that H has an la25 stub.  */
+	 branches to H, make sure that H has an la25 stub.  Only
+	 use the stub for branches from non-PIC objects; GCC's
+	 -mno-shared uses branches from PIC objects to functions
+	 which do not require $25.  */
       if (hti->info->relocatable)
 	{
 	  if (!PIC_OBJECT_P (hti->output_bfd))
 	    h->root.other = ELF_ST_SET_MIPS_PIC (h->root.other);
 	}
-      else if (h->non_pic_ref && !mips_elf_add_la25_stub (hti->info, h))
+      else if (h->has_nonpic_branches && !mips_elf_add_la25_stub (hti->info, h))
 	{
 	  hti->error = TRUE;
 	  return FALSE;

How about something like the following:

-	 non-PIC references to H, make sure that H has an la25 stub.  */
+	 non-PIC branches and jumps to H, make sure that H has an la25 stub.
+	 We specifically ignore branches and jumps from EF_PIC objects,
+	 where the onus is on the compiler or programmer to perform any
+	 necessary initialization of $25.  Sometimes such initialization
+	 is unnecessary; for example, -mno-shared functions do not use
+	 the incoming value of $25, and may therefore be called directly.  */

(Wordsmith as necessary.)  The original wording made it sound like we'd
created a stub if there were any branches at all, but that the stub
would only be used for branches from non-PIC objects.

@@ -2928,6 +2977,7 @@ mips_elf_gotplt_index (struct bfd_link_i
   struct mips_elf_link_hash_table *htab;
 
   htab = mips_elf_hash_table (info);
+  BFD_ASSERT (htab->is_vxworks);
   BFD_ASSERT (h->plt.offset != (bfd_vma) -1);
 
   /* Calculate the index of the symbol's PLT entry.  */

I think this deserves a comment.  (It's because the .got.plt
address calculation is no longer accurate after the addition
of the reserved entries, right?)  I realise this function isn't
used for non-VxWorks before the patch, but it's a generic concept
even so...

@@ -4969,6 +5009,14 @@ mips_elf_calculate_relocation (bfd *abfd
       BFD_ASSERT (sec->size > 0);
       symbol = sec->output_section->vma + sec->output_offset;
     }
+  /* If this is a direct call to a PIC function, redirect to the
+     non-PIC stub.  */
+  else if (h != NULL && h->la25_stub && !PIC_OBJECT_P (input_bfd)
+	   && (r_type == R_MIPS_26 || r_type == R_MIPS_PC16
+	       || r_type == R_MIPS16_26))
+    symbol = (h->la25_stub->stub_section->output_section->vma
+	      + h->la25_stub->stub_section->output_offset
+	      + h->la25_stub->offset);
 
   /* Calls from 16-bit code to 32-bit code and vice versa require the
      special jalx instruction.  */

I'd prefer to see some part of:

   (h != NULL
    && !PIC_OBJECT_P (input_bfd)
    && (r_type == R_MIPS_26 || r_type == R_MIPS_PC16
        || r_type == R_MIPS16_26))

be a separate function that is used both here and in
_bfd_mips_elf_check_relocs.  At least the r_type check; I don't mind how
much else.  I just think the reloc code generally is tricky enough that
even small decisions like this are worth abstracting out.

-      htab->plt_header_size = 4 * ARRAY_SIZE (mips_exec_plt0_entry);
+      htab->plt_header_size = 4 * ARRAY_SIZE (mips_o32_exec_plt0_entry);

Probably worth a comment saying that all the plt headers are the same size.
It looked a bit odd using something with "o32" in it for n32 and n64.

	  if (h && !PIC_OBJECT_P (abfd))
	    ((struct mips_elf_link_hash_entry *) h)->has_nonpic_branches = TRUE;

+      /* Refuse some position-dependent relocations when creating a
+	 shared library.  Do not refuse R_MIPS_32 / R_MIPS_64; they're
+	 not PIC, but we can create dynamic relocations and the result
+	 will be fine.  Also do not refuse R_MIPS_LO16, which can be
+	 combined with R_MIPS_GOT16.  */
+      if (info->shared)
+	{
+	  switch (r_type)
+	    {
+	    case R_MIPS16_HI16:
+	    case R_MIPS_HI16:
+	    case R_MIPS_HIGHER:
+	    case R_MIPS_HIGHEST:
+	      /* Don't refuse a high part relocation if it's against
+		 no symbol (e.g. part of a compound relocation).  */
+	      if (r_symndx == 0)
+		break;
+
+	      /* R_MIPS_HI16 against _gp_disp is used for $gp setup,
+		 and has a special meaning.  */
+	      if (!NEWABI_P (abfd) && h != NULL
+		  && strcmp (h->root.root.string, "_gp_disp") == 0)
+		break;
+
+	      /* FALLTHROUGH */
+
+	    case R_MIPS16_26:
+	    case R_MIPS_26:
+	      howto = MIPS_ELF_RTYPE_TO_HOWTO (abfd, r_type, FALSE);
+	      (*_bfd_error_handler)
+		(_("%B: relocation %s against `%s' can not be used when making a shared object; recompile with -fPIC"),
+		 abfd, howto->name,
+		 (h) ? h->root.root.string : "a local symbol");
+	      bfd_set_error (bfd_error_bad_value);
+	      return FALSE;
+	    default:
+	      break;
+	    }
+	}

FWIW, I thought about adding this too, but rejected it because I was
afraid of trapping valid uses.  E.g. it makes it impossible to use
relocations against SHN_ABS symbols, even though such symbols aren't
(generally) subject to runtime relocation.  I realise you copied this
from other ports though.

@@ -8430,10 +8540,16 @@ _bfd_mips_elf_size_dynamic_sections (bfd
       else if (SGI_COMPAT (output_bfd)
 	       && CONST_STRNEQ (name, ".compact_rel"))
 	s->size += mips_elf_hash_table (info)->compact_rel_size;
+      else if (s == htab->splt)
+	{
+	  /* If the last PLT entry has a branch delay slot, allocate
+	     room for an extra nop to fill the delay slot.  */
+	  if (!htab->is_vxworks && !info->shared && s->size > 0)
+	    s->size += 4;
+	}
       else if (! CONST_STRNEQ (name, ".init")
 	       && s != htab->sgot
 	       && s != htab->sgotplt
-	       && s != htab->splt
 	       && s != htab->sstubs
 	       && s != htab->sdynbss)
 	{

Why !info->shared?

@@ -9604,17 +9727,21 @@ mips_finish_exec_plt (bfd *output_bfd, s
   gotplt_value_high = ((gotplt_value + 0x8000) >> 16) & 0xffff;
   gotplt_value_low = gotplt_value & 0xffff;
 
+  /* The PLT sequence is not safe for N64 if .got.plt is above the 2GB
+     mark.  */
+  BFD_ASSERT ((gotplt_value >> 31) == 0);
+
   /* Pick the load opcode.  */
   load = MIPS_ELF_LOAD_WORD (output_bfd);
 
   /* Install the PLT header.  */
   loc = htab->splt->contents;
-  bfd_put_32 (output_bfd, plt_entry[0] | got_value_high, loc);
-  bfd_put_32 (output_bfd, plt_entry[1] | got_value_low | load, loc + 4);
-  bfd_put_32 (output_bfd, plt_entry[2] | got_value_low, loc + 8);
-  bfd_put_32 (output_bfd, plt_entry[3] | gotplt_value_high, loc + 12);
+  bfd_put_32 (output_bfd, plt_entry[0] | gotplt_value_high, loc);
+  bfd_put_32 (output_bfd, plt_entry[1] | gotplt_value_low | load, loc + 4);
+  bfd_put_32 (output_bfd, plt_entry[2] | gotplt_value_low, loc + 8);
+  bfd_put_32 (output_bfd, plt_entry[3], loc + 12);
   bfd_put_32 (output_bfd, plt_entry[4], loc + 16);
-  bfd_put_32 (output_bfd, plt_entry[5] | gotplt_value_low, loc + 20);
+  bfd_put_32 (output_bfd, plt_entry[5], loc + 20);
   bfd_put_32 (output_bfd, plt_entry[6], loc + 24);
   bfd_put_32 (output_bfd, plt_entry[7], loc + 28);
 }

I think it'd be good to tighten the assert, as it would currently trigger
for valid X >= -0x80000000 addresses (both in 32-bit and 64-bit code).
I don't know of any system out there that allows dynamic executables
in kernel space, but I've ceased to be surprised by such things ;)

+/* Return TRUE if symbol should be hashed in the `.gnu.hash' section.  */
+
+bfd_boolean
+_bfd_mips_elf_hash_symbol (struct elf_link_hash_entry *h)
+{
+  struct mips_elf_link_hash_entry *hmips;
+
+  hmips = (struct mips_elf_link_hash_entry *) h;
+  if (h->plt.offset != MINUS_ONE
+      && hmips->no_fn_stub
+      && !h->def_regular
+      && !h->pointer_equality_needed)
+    return FALSE;
+
+  return _bfd_elf_hash_symbol (h);
+}

Were you able to test this, given:

static void
mips_after_parse (void)
{
  /* .gnu.hash and the MIPS ABI require .dynsym to be sorted in different
     ways.  .gnu.hash needs symbols to be grouped by hash code whereas the
     MIPS ABI requires a mapping between the GOT and the symbol table.  */
  if (link_info.emit_gnu_hash)
    {
      einfo ("%X%P: .gnu.hash is incompatible with the MIPS ABI\n");
      link_info.emit_hash = TRUE;
      link_info.emit_gnu_hash = FALSE;
    }
  after_parse_default ();
}

?  FWIW, if it's dead code, I'd prefer to leave it out.

+      printf (_(" Entries:\n"));
+      printf (_("  %*s %*s %*s %-7s %3s %s\n"),
+	      addr_size * 2, "Address",
+	      addr_size * 2, "Initial",
+	      addr_size * 2, "Sym.Val.", "Type", "Ndx", "Name");
+      sym_width = (is_32bit_elf ? 80 : 160) - 28 - addr_size * 6 - 1;

"- 17" rather than "- 28"?  In the global GOT code, "28 - addr_size * 6"
is the width of the format before the final "%s".  However, the global GOT
entries have an additional 10-char field and space separator, so the width
there is 11 greater than here.

Index: binutils-mainline/ld/testsuite/ld-mips-elf/pic-and-nonpic-3b.dd
===================================================================
--- binutils-mainline.orig/ld/testsuite/ld-mips-elf/pic-and-nonpic-3b.dd	2008-07-16 09:25:17.000000000 -0700
+++ binutils-mainline/ld/testsuite/ld-mips-elf/pic-and-nonpic-3b.dd	2008-07-22 10:43:08.000000000 -0700
@@ -2,50 +2,52 @@
 #
 # -32752: lazy resolution function
 # -32748: reserved for module pointer
-# -32744: PLT resolution function
-# -32740: GOT page entry.
-# -32736: bar's GOT entry
+# -32744: GOT page entry.
+# -32740: bar's GOT entry
 
 .*
 
 Disassembly of section \.plt:
 
-00043010 <.*>:
-   43010:	3c0f000a 	lui	t7,0xa
-   43014:	8df90008 	lw	t9,8\(t7\)
-   43018:	25ef0008 	addiu	t7,t7,8
-   4301c:	3c0e0008 	lui	t6,0x8
-   43020:	03200008 	jr	t9
-   43024:	25ce1000 	addiu	t6,t6,4096
-	\.\.\.
+.* <.*>:
+.*:	3c1c0008 	lui	gp,0x8
+.*:	8f991000 	lw	t9,4096\(gp\)
+.*:	279c1000 	addiu	gp,gp,4096
+.*:	031cc023 	subu	t8,t8,gp
+.*:	03e07821 	move	t7,ra
+.*:	0018c082 	srl	t8,t8,0x2
+.*:	0320f809 	jalr	t9
+.*:	2718fffe 	addiu	t8,t8,-2
+
+.* <foo@plt>:
+.*:	3c0f0008 	lui	t7,0x8
+.*:	8df91008 	lw	t9,4104\(t7\)
+.*:	25f81008 	addiu	t8,t7,4104
+.*:	03200008 	jr	t9
+.*:	00000000 	nop
 
-00043030 <foo@plt>:
-   43030:	3c180008 	lui	t8,0x8
-   43034:	8f191000 	lw	t9,4096\(t8\)
-   43038:	03200008 	jr	t9
-   4303c:	27181000 	addiu	t8,t8,4096
 Disassembly of section \.text:
 
-00044000 <__start>:
-   44000:	0c010c0c 	jal	43030 <foo@plt>
-   44004:	00000000 	nop
-   44008:	08011004 	j	44010 <ext>
-   4400c:	00000000 	nop
-
-00044010 <ext>:
-   44010:	3c1c000a 	lui	gp,0xa
-   44014:	279c7ff0 	addiu	gp,gp,32752
-   44018:	8f82801c 	lw	v0,-32740\(gp\)
-   4401c:	24421000 	addiu	v0,v0,4096
-   44020:	8f998020 	lw	t9,-32736\(gp\)
-   44024:	03200008 	jr	t9
-   44028:	00000000 	nop
-   4402c:	00000000 	nop
+.* <__start>:
+.*:	0c010c10 	jal	43040 <foo@plt>
+.*:	00000000 	nop
+.*:	08011004 	j	44010 <ext>
+.*:	00000000 	nop
+
+.* <ext>:
+.*:	3c1c000a 	lui	gp,0xa
+.*:	279c7ff0 	addiu	gp,gp,32752
+.*:	8f828018 	lw	v0,-32744\(gp\)
+.*:	24421000 	addiu	v0,v0,4096
+.*:	8f99801c 	lw	t9,-32740\(gp\)
+.*:	03200008 	jr	t9
+.*:	00000000 	nop
+.*:	00000000 	nop
 Disassembly of section .MIPS.stubs:
 
-00044030 <\.MIPS\.stubs>:
-   44030:	8f998010 	lw	t9,-32752\(gp\)
-   44034:	03e07821 	move	t7,ra
-   44038:	0320f809 	jalr	t9
-   4403c:	24180007 	li	t8,7
+.* <\.MIPS\.stubs>:
+.*:	8f998010 	lw	t9,-32752\(gp\)
+.*:	03e07821 	move	t7,ra
+.*:	0320f809 	jalr	t9
+.*:	24180007 	li	t8,7
 	\.\.\.

Please keep the "... <...>:" addresses at least.  (You did this
in some of the other tests, thanks.)  The non-disassembly dumps
rely on functions being at certain addresses, and I think it's
easier to follow the test if those addresses are explicit in
the disassembly.

(I've used custom scripts for this sort of test to try to
protect them from fluctuations in the size of the dynamic info.
The addresses should be pretty stable.)

Richard
