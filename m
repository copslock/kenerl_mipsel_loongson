Received:  by oss.sgi.com id <S42333AbQIGIRG>;
	Thu, 7 Sep 2000 01:17:06 -0700
Received: from Cantor.suse.de ([194.112.123.193]:24590 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42441AbQIGIQr>;
	Thu, 7 Sep 2000 01:16:47 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 85EA41E2A4; Thu,  7 Sep 2000 10:16:45 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id 8206F10A052; Thu,  7 Sep 2000 10:16:44 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 13Ww9q-0003rr-00; Thu, 07 Sep 2000 09:31:38 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 3BBA31822; Thu,  7 Sep 2000 09:31:37 +0200 (CEST)
Mail-Copies-To: never
To:     Guido Guenther <guido.guenther@gmx.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: latest glibc from cvs fails to build
References: <20000906222133.A1052@bilbo.physik.uni-konstanz.de>
From:   Andreas Jaeger <aj@suse.de>
Date:   07 Sep 2000 09:31:36 +0200
In-Reply-To: Guido Guenther's message of "Wed, 6 Sep 2000 22:21:33 +0200"
Message-ID: <u8d7ig1wvb.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Guido Guenther writes:

 > Hi,
 > when cross-building glibc from today's cvs with gcc 2.96 (20000828) I get
 > the following error:
 > dl-reloc.c:104:50: warning: pasting would not give a valid
 > preprocessing token
 > dl-reloc.c:112:50: warning: pasting would not give a valid
 > preprocessing token
Ignore those warnings
 > In file included from dynamic-link.h:21,
 >                  from dl-reloc.c:92:
 > ../sysdeps/mips/dl-machine.h:542: too few arguments to function
 > `_dl_lookup_versioned_symbol'
 > ../sysdeps/mips/dl-machine.h:542: too few arguments to function
 > `_dl_lookup_symbol'

 > Does this look familiar to anyone? Otherwise I'll take a look at it
 > later this week.
I'm currently testing a patch for this, my current version is appended.

Andreas

============================================================
Index: sysdeps/mips/dl-machine.h
--- sysdeps/mips/dl-machine.h	2000/07/25 10:32:02	1.40
+++ sysdeps/mips/dl-machine.h	2000/09/07 07:31:13
@@ -262,14 +262,14 @@
 	      {								      \
 		value = _dl_lookup_versioned_symbol(strtab + sym->st_name, l, \
 						    &sym, l->l_scope, version,\
-						    R_MIPS_REL32);	      \
+						    R_MIPS_REL32, 0);	      \
 		break;							      \
 	      }								      \
 	    /* Fall through.  */					      \
 	  }								      \
 	case 0:								      \
 	  value = _dl_lookup_symbol (strtab + sym->st_name, l, &sym,	      \
-				     l->l_scope, R_MIPS_REL32);		      \
+				     l->l_scope, R_MIPS_REL32, 0);	      \
 	}								      \
 									      \
       /* Currently value contains the base load address of the object	      \
@@ -495,14 +495,14 @@
 		value = _dl_lookup_versioned_symbol(strtab + sym->st_name,\
 						    map,		  \
 						    &ref, scope, version, \
-						    R_MIPS_REL32);	  \
+						    R_MIPS_REL32, 0);	  \
 		break;							  \
 	      }								  \
 	    /* Fall through.  */					  \
 	  }								  \
 	case 0:								  \
 	  value = _dl_lookup_symbol (strtab + sym->st_name, map, &ref,	  \
-				     scope, R_MIPS_REL32);		  \
+				     scope, R_MIPS_REL32, 0);		  \
 	}								  \
 									  \
       (ref)? value + ref->st_value: 0;					  \

 > Regards,
 >  -- Guido

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
