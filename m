Received:  by oss.sgi.com id <S42223AbQGJNzj>;
	Mon, 10 Jul 2000 06:55:39 -0700
Received: from firewall.spacetec.no ([192.51.5.5]:20724 "EHLO
        pallas.spacetec.no") by oss.sgi.com with ESMTP id <S42185AbQGJNz3>;
	Mon, 10 Jul 2000 06:55:29 -0700
Received: (from tor@localhost)
	by pallas.spacetec.no (8.9.1a/8.9.1) id PAA04630;
	Mon, 10 Jul 2000 15:55:35 +0200
Message-Id: <200007101355.PAA04630@pallas.spacetec.no>
From:   tor@spacetec.no (Tor Arntsen)
Date:   Mon, 10 Jul 2000 15:55:34 +0200
In-Reply-To: Ralf Baechle <ralf@oss.sgi.com>
       "Re: Kernel boot tips." (Jul  9, 21:59)
X-Mailer: Mail User's Shell (7.2.6 beta(4) 03/19/98)
To:     ralf@oss.sgi.com
Subject: Re: Kernel boot tips.
Cc:     linux-mips@oss.sgi.com, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Jul 9, 21:59, Ralf Baechle wrote:
>I've finally commited my rewrite of dvhtool into the CVS archive on
>oss.  It's not yet complete but hackers may be interested in taking a
>look at it.
[..]

This looks great. Just for fun I did a quick compile under irix 6.5.8 on 
an SGI Octane, dvhtool --print-all and dvhtool --print-all /dev/rdsk/dksXXXvh 
worked fine. --vh-to-unix failed with 'Short read: Error 0', I assume this 
simply isn't finished yet (or maybe it doesn't work under irix).
BTW it compiled fine with gcc as well as with the MIPSPro compiler (after
replacing this little gcc'ism:)
--- dvhlib.c.orig       Fri Jul  7 04:24:53 2000
+++ dvhlib.c    Mon Jul 10 15:43:51 2000
@@ -40,7 +40,7 @@
        case PTYPE_XFS:         return "XFS";
        case PTYPE_XFSLOG:      return "XFS Log";
        case PTYPE_XLV:         return "XLV Volume";
-       case 13 ... 15:         return "Unknown Partition Type";
+       default:                return "Unknown Partition Type";
        }
 
        return "Invalid Type";
