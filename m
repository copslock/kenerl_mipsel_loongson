Received:  by oss.sgi.com id <S42275AbQIWV7J>;
	Sat, 23 Sep 2000 14:59:09 -0700
Received: from u-161.karlsruhe.ipdial.viaginterkom.de ([62.180.10.161]:37636
        "EHLO u-161.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42261AbQIWV6t>; Sat, 23 Sep 2000 14:58:49 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869543AbQIWVGc>;
        Sat, 23 Sep 2000 23:06:32 +0200
Date:   Sat, 23 Sep 2000 23:06:32 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Brady Brown <bbrown@ti.com>
Cc:     Keith Owens <kaos@melbourne.sgi.com>,
        SGI news group <linux-mips@oss.sgi.com>,
        Ulf Carlsson <ulfc@engr.sgi.com>
Subject: Re: ELF/Modutils problem
Message-ID: <20000923230632.A1639@bacchus.dhis.org>
References: <20000921153631.A1238@bacchus.dhis.org> <1690.969616620@ocs3.ocs-net> <20000922153156.A2677@bacchus.dhis.org> <39CB7978.E222DF8E@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39CB7978.E222DF8E@ti.com>; from bbrown@ti.com on Fri, Sep 22, 2000 at 09:23:36AM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 22, 2000 at 09:23:36AM -0600, Brady Brown wrote:

> > Ulf Carlsson <ulfc@engr.sgi.com> is currently maintaining binutils.
> > Ulf, you got the bandwidth to take a look at this?  After a look over the
> > gas code it's not obvious to my why this doesn't work on MIPS but on
> > all the other architectures, you probably know the internals of this beast
> > better than I do.
> 
> I'm not sure what exact piece of the tool chain forms the un-linked elf file,
> but as I stated originally the symbol table in the .o file is incorrect after
> compiling and then if I do an incremental link (-r) the symbol table and
> length pointer have been corrected. Based upon this it looks like the output
> from the linker is correct, but the output from the earlier stage is wrong.

It's the assembler as below text case demonstrates.

  Ralf

#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.2.1).
# To extract the files from this archive, save it to some FILE, remove
# everything before the `!/bin/sh' line above, then type `sh FILE'.
#
# Made on 2000-09-23 23:03 MEST by <ralf@lappi.waldorf-gmbh.de>.
# Source directory was `/home/ralf/src/binutils'.
#
# Existing files will *not* be overwritten unless `-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#     37 -rw-rw-r-- nuke-as-01/s.s
#    161 -rw-r--r-- nuke-as-01/Makefile
#
save_IFS="${IFS}"
IFS="${IFS}:"
gettext_dir=FAILED
locale_dir=FAILED
first_param="$1"
for dir in $PATH
do
  if test "$gettext_dir" = FAILED && test -f $dir/gettext \
     && ($dir/gettext --version >/dev/null 2>&1)
  then
    set `$dir/gettext --version 2>&1`
    if test "$3" = GNU
    then
      gettext_dir=$dir
    fi
  fi
  if test "$locale_dir" = FAILED && test -f $dir/shar \
     && ($dir/shar --print-text-domain-dir >/dev/null 2>&1)
  then
    locale_dir=`$dir/shar --print-text-domain-dir`
  fi
done
IFS="$save_IFS"
if test "$locale_dir" = FAILED || test "$gettext_dir" = FAILED
then
  echo=echo
else
  TEXTDOMAINDIR=$locale_dir
  export TEXTDOMAINDIR
  TEXTDOMAIN=sharutils
  export TEXTDOMAIN
  echo="$gettext_dir/gettext -s"
fi
if touch -am -t 200112312359.59 $$.touch >/dev/null 2>&1 && test ! -f 200112312359.59 -a -f $$.touch; then
  shar_touch='touch -am -t $1$2$3$4$5$6.$7 "$8"'
elif touch -am 123123592001.59 $$.touch >/dev/null 2>&1 && test ! -f 123123592001.59 -a ! -f 123123592001.5 -a -f $$.touch; then
  shar_touch='touch -am $3$4$5$6$1$2.$7 "$8"'
elif touch -am 1231235901 $$.touch >/dev/null 2>&1 && test ! -f 1231235901 -a -f $$.touch; then
  shar_touch='touch -am $3$4$5$6$2 "$8"'
else
  shar_touch=:
  echo
  $echo 'WARNING: not restoring timestamps.  Consider getting and'
  $echo "installing GNU \`touch', distributed in GNU File Utilities..."
  echo
fi
rm -f 200112312359.59 123123592001.59 123123592001.5 1231235901 $$.touch
#
if mkdir _sh01696; then
  $echo 'x -' 'creating lock directory'
else
  $echo 'failed to create lock directory'
  exit 1
fi
# ============= nuke-as-01/s.s ==============
if test ! -d 'nuke-as-01'; then
  $echo 'x -' 'creating directory' 'nuke-as-01'
  mkdir 'nuke-as-01'
fi
if test -f 'nuke-as-01/s.s' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'nuke-as-01/s.s' '(file already exists)'
else
  $echo 'x -' extracting 'nuke-as-01/s.s' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'nuke-as-01/s.s' &&
X	.globl	x1
x1:	.word	x1
x2:	.word	x2
SHAR_EOF
  (set 20 00 09 22 02 42 43 'nuke-as-01/s.s'; eval "$shar_touch") &&
  chmod 0664 'nuke-as-01/s.s' ||
  $echo 'restore of' 'nuke-as-01/s.s' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'nuke-as-01/s.s:' 'MD5 check failed'
509bca5a5362c487c805dbc79d9d32a8  nuke-as-01/s.s
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'nuke-as-01/s.s'`"
    test 37 -eq "$shar_count" ||
    $echo 'nuke-as-01/s.s:' 'original size' '37,' 'current size' "$shar_count!"
  fi
fi
# ============= nuke-as-01/Makefile ==============
if test -f 'nuke-as-01/Makefile' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'nuke-as-01/Makefile' '(file already exists)'
else
  $echo 'x -' extracting 'nuke-as-01/Makefile' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'nuke-as-01/Makefile' &&
target = mips64-linux-
AS = $(target)as
OBJDUMP = $(target)objdump
READELF = $(target)readelf
X
CFLAGS =
X
all:	s.o
X	$(READELF) -s $^
X
clean distclean:
X	rm -f s.o
SHAR_EOF
  (set 20 00 09 21 15 47 28 'nuke-as-01/Makefile'; eval "$shar_touch") &&
  chmod 0644 'nuke-as-01/Makefile' ||
  $echo 'restore of' 'nuke-as-01/Makefile' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'nuke-as-01/Makefile:' 'MD5 check failed'
4d263e9d27b40dbb44f9fadc00160fa5  nuke-as-01/Makefile
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'nuke-as-01/Makefile'`"
    test 161 -eq "$shar_count" ||
    $echo 'nuke-as-01/Makefile:' 'original size' '161,' 'current size' "$shar_count!"
  fi
fi
rm -fr _sh01696
exit 0
