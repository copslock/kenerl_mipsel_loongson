Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56LeXi10420
	for linux-mips-outgoing; Wed, 6 Jun 2001 14:40:33 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56LeWh10409
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 14:40:32 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E37A7125BC; Wed,  6 Jun 2001 14:40:31 -0700 (PDT)
Date: Wed, 6 Jun 2001 14:40:31 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: gcc-patches@gcc.gnu.org
Cc: linux-mips@oss.sgi.com
Subject: A patch for mips.md
Message-ID: <20010606144031.A27654@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Linux/mips, I got

# gcc -O0  -c gcc/testsuite/gcc.c-torture/compile/20010107-1.c
/tmp/cc42wjvw.s: Assembler messages:
/tmp/cc42wjvw.s:22: Error: illegal operands `move

This patch seems to work for me.


H.J.
---
2001-06-06  H.J. Lu  (hjl@gnu.org)

	* config/mips/mips.md (call_internal2): Use "lw" if the target
	is not a register.
	(call_value_internal2): Likewise.
	(call_value_multiple_internal2): Likewise.

--- gcc/config/mips/mips.md.call	Fri Jun  1 23:28:12 2001
+++ gcc/config/mips/mips.md	Fri Jun  1 23:35:45 2001
@@ -9547,6 +9547,8 @@ ld\\t%2,%1-%S1(%2)\;daddu\\t%2,%2,$31\;j
     }
   else if (GET_CODE (target) == CONST_INT)
     return \"li\\t%^,%0\\n\\tjal\\t%2,%^\";
+  else if (GET_CODE (target) != REG)
+    return \"lw\\t%^,%0\\n\\tjal\\t%2,%^\";
   else if (REGNO (target) != PIC_FUNCTION_ADDR_REGNUM)
     return \"move\\t%^,%0\\n\\tjal\\t%2,%^\";
   else
@@ -9755,6 +9757,8 @@ ld\\t%2,%1-%S1(%2)\;daddu\\t%2,%2,$31\;j
     }
   else if (GET_CODE (target) == CONST_INT)
     return \"li\\t%^,%1\\n\\tjal\\t%3,%^\";
+  else if (GET_CODE (target) != REG)
+    return \"lw\\t%^,%1\\n\\tjal\\t%3,%^\";
   else if (REGNO (target) != PIC_FUNCTION_ADDR_REGNUM)
     return \"move\\t%^,%1\\n\\tjal\\t%3,%^\";
   else
@@ -9890,6 +9894,8 @@ ld\\t%2,%1-%S1(%2)\;daddu\\t%2,%2,$31\;j
     }
   else if (GET_CODE (target) == CONST_INT)
     return \"li\\t%^,%1\\n\\tjal\\t%4,%^\";
+  else if (GET_CODE (target) != REG)
+    return \"lw\\t%^,%1\\n\\tjal\\t%4,%^\";
   else if (REGNO (target) != PIC_FUNCTION_ADDR_REGNUM)
     return \"move\\t%^,%1\\n\\tjal\\t%4,%^\";
   else
