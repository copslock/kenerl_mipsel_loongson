Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6JaEq28201
	for linux-mips-outgoing; Thu, 6 Dec 2001 11:36:14 -0800
Received: from ocean.lucon.org ([12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB6Ja7o28194;
	Thu, 6 Dec 2001 11:36:07 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id DF79C125C1; Thu,  6 Dec 2001 10:36:05 -0800 (PST)
Date: Thu, 6 Dec 2001 10:36:05 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com, config-patches@gnu.org
Subject: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
Message-ID: <20011206103605.A7366@lucon.org>
References: <20011206093506.A6496@lucon.org> <20011206155724.A11083@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206155724.A11083@dea.linux-mips.net>; from ralf@oss.sgi.com on Thu, Dec 06, 2001 at 03:57:24PM -0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 06, 2001 at 03:57:24PM -0200, Ralf Baechle wrote:
> On Thu, Dec 06, 2001 at 09:35:06AM -0800, H . J . Lu wrote:
> 
> > The byteorder field is emoved from /proc/cpuinfo in the current 2.4
> > kernel in CVS. It breaks config.guess used by all the GNU softwares.
> 
> Grrr...  In the past config.guess used gcc to compile a test program using
> gcc.  I told sometime ago to whoever it was that I'm going to remove
> all non-cpu related information (endianess should be considered per
> _thread_ on MIPS!) from /proc/cpuinfo where it has no business; the /proc
> rewrite in 2.4.15 more or less forced me into this.
> 

How about this patch?


H.J.
---
2001-12-06  H.J. Lu  (hjl@gnu.org)

	* config.guess: Properly handle Linux/mips.

--- config.guess.mips	Mon Nov  5 08:09:32 2001
+++ config.guess	Thu Dec  6 10:31:40 2001
@@ -767,10 +767,21 @@ EOF
 	echo ${UNAME_MACHINE}-unknown-linux-gnu
 	exit 0 ;;
     mips:Linux:*:*)
-	case `sed -n '/^byte/s/^.*: \(.*\) endian/\1/p' < /proc/cpuinfo` in
-	  big)    echo mips-unknown-linux-gnu && exit 0 ;;
-	  little) echo mipsel-unknown-linux-gnu && exit 0 ;;
-	esac
+	eval $set_cc_for_build
+	cat >$dummy.c <<EOF
+#if defined(__MIPSEL__) || defined(__MIPSEL) || defined(_MIPSEL) || defined(MIPSEL)
+cpu=mipsel
+#endif
+#if defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || defined(MIPSEB)
+cpu=mips
+#endif
+EOF
+	cpu=
+	eval `$CC_FOR_BUILD -E $dummy.c | grep cpu=`;
+	rm -f $dummy.c
+	if test -n "$cpu"; then
+	  echo $cpu-unknown-linux-gnu && exit 0
+	fi
 	;;
     ppc:Linux:*:*)
 	echo powerpc-unknown-linux-gnu
