Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id FAA135042 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 05:58:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA13589 for linux-list; Mon, 24 Nov 1997 05:55:58 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA13578 for <linux@engr.sgi.com>; Mon, 24 Nov 1997 05:55:56 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA20717
	for <linux@engr.sgi.com>; Mon, 24 Nov 1997 05:55:52 -0800
	env-from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (ralf@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id OAA00951
	for <linux@engr.sgi.com>; Mon, 24 Nov 1997 14:55:45 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id OAA14380;
	Mon, 24 Nov 1997 14:29:29 +0100
Message-ID: <19971124142928.47050@lappi.waldorf-gmbh.de>
Date: Mon, 24 Nov 1997 14:29:28 +0100
From: ralf@uni-koblenz.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Announce: binutils rpm package
References: <19971124054518.62045@lappi.waldorf-gmbh.de> <m0xZxFA-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=81UyVL57Vl7rS8Cx
X-Mailer: Mutt 0.85
In-Reply-To: <m0xZxFA-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Mon, Nov 24, 1997 at 12:04:00PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--81UyVL57Vl7rS8Cx
Content-Type: text/plain; charset=us-ascii

On Mon, Nov 24, 1997 at 12:04:00PM +0000, Alan Cox wrote:

> > I've uploaded little endian native binaries and a source rpm package
> > of binutils-2.8.1-1 to ftp.linux.sgi.com.
> > 
> >   Ralf
> > 
> > f234b72cc2982ec4e2d88db6d700b3b5  binutils-2.8.1-1.mips.rpm
> > d71aeb4d0f36d4a40bb44714099520e3  binutils-2.8.1-1.src.rpm
> 
> The SRPM appears corrupt - its about 1Meg short

Thanks, I'll try to upload it as a single part later the day when
phone fees are reasonable insane[*].  So long if you want to rebuild
the package for the Indy, you can use the attached spec file and
patch (identical to the one on Linus) plus the binutils-2.8.1.tar.gz
file from Redhat's binutils-2.8.1-1 package.  (binutils-2.8.1.tar.gz
should be the FSF version.)

  Ralf

*: Sorry, Ron ...

--81UyVL57Vl7rS8Cx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="binutils-2.8.1-mips.patch"

diff -urN binutils-2.8.1.orig/gas/ChangeLog binutils-2.8.1/gas/ChangeLog
--- binutils-2.8.1.orig/gas/ChangeLog	Mon May 26 10:32:45 1997
+++ binutils-2.8.1/gas/ChangeLog	Tue Oct 21 03:32:24 1997
@@ -1,3 +1,10 @@
+Tue Oct 21 03:23:59 1997  Ralf Baechle  <ralf@gnu.ai.mit.edu>
+
+	* config/tc-mips.c (macro): Only emit a BFD_RELOC_MIPS_LITERAL
+	when the symbol is in the .lit section.  Required for a.out
+	support.
+	(mips_ip): Fix %HI, %hi and %lo operators.
+
 Mon May 26 13:24:25 1997  Ian Lance Taylor  <ian@cygnus.com>
 
 	* doc/as.texinfo: Don't use @value in section names or index
diff -urN binutils-2.8.1.orig/gas/config/tc-mips.c binutils-2.8.1/gas/config/tc-mips.c
--- binutils-2.8.1.orig/gas/config/tc-mips.c	Mon May 26 10:32:40 1997
+++ binutils-2.8.1/gas/config/tc-mips.c	Tue Oct 21 03:22:48 1997
@@ -4863,13 +4863,22 @@
       else
 	{
 	  assert (offset_expr.X_op == O_symbol
-		  && strcmp (segment_name (S_GET_SEGMENT
-					   (offset_expr.X_add_symbol)),
-			     ".lit4") == 0
 		  && offset_expr.X_add_number == 0);
-	  macro_build ((char *) NULL, &icnt, &offset_expr, "lwc1", "T,o(b)",
-		       treg, (int) BFD_RELOC_MIPS_LITERAL, GP);
-	  return;
+	  s = segment_name (S_GET_SEGMENT (offset_expr.X_add_symbol));
+	  if (strcmp (s, ".lit4") == 0)
+	    {
+	      macro_build ((char *) NULL, &icnt, &offset_expr, "lwc1", "T,o(b)",
+			   treg, (int) BFD_RELOC_MIPS_LITERAL, GP);
+	      return;
+	    }
+	  else
+	    {
+	      /* FIXME: This won't work for a 64 bit address.  */
+	      macro_build_lui ((char *) NULL, &icnt, &offset_expr, AT);
+	      macro_build ((char *) NULL, &icnt, &offset_expr, "lwc1", "T,o(b)",
+			   treg, (int) BFD_RELOC_LO16, AT);
+	      return;
+	    }
 	}
 
     case M_LI_D:
@@ -6965,11 +6974,23 @@
 	      c = my_getSmallExpression (&imm_expr, s);
 	      if (c != '\0')
 		{
-		  if (c != 'l')
+		  if (c == 'l')
+		    {
+		      if (imm_expr.X_op == O_constant)
+			{
+			  imm_expr.X_add_number &= 0xffff;
+			  imm_reloc = BFD_RELOC_LO16;
+			}
+		    }
+		  else
 		    {
 		      if (imm_expr.X_op == O_constant)
-			imm_expr.X_add_number =
-			  (imm_expr.X_add_number >> 16) & 0xffff;
+			{
+			  if (c == 'h' && (imm_expr.X_add_number & 0x8000))
+			    imm_expr.X_add_number += 0x1000;
+			  imm_expr.X_add_number =
+			    (imm_expr.X_add_number >> 16) & 0xffff;
+			}
 		      else if (c == 'h')
 			{
 			  imm_reloc = BFD_RELOC_HI16_S;
@@ -7064,11 +7085,22 @@
 		break;
 
 	      offset_reloc = BFD_RELOC_LO16;
-	      if (c == 'h' || c == 'H')
+	      if (c)
 		{
-		  assert (offset_expr.X_op == O_constant);
-		  offset_expr.X_add_number =
-		    (offset_expr.X_add_number >> 16) & 0xffff;
+		  if (c != 'l')
+		    {
+		      if (offset_expr.X_op == O_constant)
+			{
+			  if (c == 'h' && (offset_expr.X_add_number & 0x8000))
+			    offset_expr.X_add_number += 0x1000;
+			  offset_expr.X_add_number =
+			    (offset_expr.X_add_number >> 16) & 0xffff;
+			}
+		      else if (c == 'h')
+			offset_reloc = BFD_RELOC_HI16_S;
+		      else
+			offset_reloc = BFD_RELOC_HI16;
+		    }
 		}
 	      s = expr_end;
 	      continue;
@@ -7081,10 +7113,13 @@
 
 	    case 'u':		/* upper 16 bits */
 	      c = my_getSmallExpression (&imm_expr, s);
-	      if (imm_expr.X_op == O_constant
-		  && (imm_expr.X_add_number < 0
-		      || imm_expr.X_add_number >= 0x10000))
-		as_bad ("lui expression not in range 0..65535");
+	      if (!c)
+		{
+		  if (imm_expr.X_op == O_constant
+		      && (imm_expr.X_add_number < 0
+			  || imm_expr.X_add_number >= 0x10000))
+		    as_bad ("lui expression not in range 0..65535");
+		}
 	      imm_reloc = BFD_RELOC_LO16;
 	      if (c)
 		{

--81UyVL57Vl7rS8Cx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="binutils-2.8.1.spec"

Summary: GNU Binary Utility Development Utilities
Name: binutils
Version: 2.8.1
Release: 1
Copyright: GPL
Group: Development/Tools
Source: ftp://prep.ai.mit.edu/pub/gnu/binutils-2.8.1.tar.gz
Patch: binutils-2.8.1-mips.patch
BuildRoot: /tmp/binutils-root
%description
binutils is a collection of utilities necessary for compiling programs. It
includes the assembler and linker, as well as a number of other
miscellaneous programs for dealing with executable formats.

%prep
%setup
%patch -p1

%build
./configure --prefix=/usr --enable-shared
make tooldir=/usr
make tooldir=/usr info

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr
make tooldir=$RPM_BUILD_ROOT/usr prefix=$RPM_BUILD_ROOT/usr install install-info
strip $RPM_BUILD_ROOT/usr/bin/*
gzip -q9f $RPM_BUILD_ROOT/usr/info/*.info*

# Get rid of that arch-specific directory
rm -rf $RPM_BUILD_ROOT/usr/lib/bin

install -m 644 libiberty/libiberty.a $RPM_BUILD_ROOT/usr/lib
install -m 644 include/libiberty.h $RPM_BUILD_ROOT/usr/include

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files
%doc README
/usr/bin/*
/usr/man/man1/*
/usr/include/*
/usr/lib/*
/usr/info*

--81UyVL57Vl7rS8Cx--
