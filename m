Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16M0MV00886
	for linux-mips-outgoing; Wed, 6 Feb 2002 14:00:22 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16M0IA00883
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 14:00:18 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 06A4C125C8; Wed,  6 Feb 2002 14:00:16 -0800 (PST)
Date: Wed, 6 Feb 2002 14:00:16 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ian Lance Taylor <ian@airs.com>
Cc: Eric Christopher <echristo@redhat.com>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com, gcc-patches@gcc.gnu.org
Subject: PATCH: Define SUBTARGET_ASM_DEBUGGING_SPEC for Linux/mips
Message-ID: <20020206140016.A30178@lucon.org>
References: <15454.47823.837119.847975@gladsmuir.algor.co.uk> <20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org> <20020205113017.A6144@lucon.org> <20020205135407.A8309@lucon.org> <20020206113259.A15431@dea.linux-mips.net> <20020206124538.A28632@lucon.org> <20020206130037.A29208@lucon.org> <1013030208.19162.6.camel@ghostwheel.cygnus.com> <si665ap9vf.fsf@daffy.airs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <si665ap9vf.fsf@daffy.airs.com>; from ian@airs.com on Wed, Feb 06, 2002 at 01:40:20PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 06, 2002 at 01:40:20PM -0800, Ian Lance Taylor wrote:
> 
> H.J., my question on this patch would be: why is -g being passed to
> the assembler?
> 

Here is a patch similar to Irix 6.


H.J.
----
2002-02-06  H.J. Lu <hjl@gnu.org>

	* config/mips/linux.h (SUBTARGET_ASM_DEBUGGING_SPEC): Defined.

--- gcc/config/mips/linux.h.gas	Thu Nov 15 12:21:17 2001
+++ gcc/config/mips/linux.h	Wed Feb  6 13:57:47 2002
@@ -170,6 +170,9 @@ Boston, MA 02111-1307, USA.  */
 %{!fno-PIC:%{!fno-pic:-KPIC}} \
 %{fno-PIC:-non_shared} %{fno-pic:-non_shared}"
 
+#undef SUBTARGET_ASM_DEBUGGING_SPEC
+#define SUBTARGET_ASM_DEBUGGING_SPEC "-g0"
+
 /* We don't need those nonsenses.  */
 #undef INVOKE__main
 #undef CTOR_LIST_BEGIN
