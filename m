Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 21:12:41 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:56569 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225281AbTHFUMj>;
	Wed, 6 Aug 2003 21:12:39 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA14671
	for <linux-mips@linux-mips.org>; Wed, 6 Aug 2003 13:12:36 -0700
Message-ID: <3F316133.3FF2C9EC@mvista.com>
Date: Wed, 06 Aug 2003 14:12:35 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: PATCH:2.4:CONFIG_CMDLINE_BOOL
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips

The patch at the bottom of this message adds support so that
a board can choose to have a command line specified in
the .config file or hard-coded. This is similar to what is
in the ppc tree.  All this patch does is create a config
question and store the info in the config file.  It is up
to each board to read or not read this info.

Here is one example of its use:
>#ifndef CONFIG_CMDLINE_BOOL
>#define CONFIG_CMDLINE "console=ttyS0,38400 ip=any root=nfs rw"
>#endif
>char arcs_cmdline[CL_SIZE] = CONFIG_CMDLINE;

Dynamic setting of args like this will still work with out
any changes. 
>#ifdef CONFIG_NE2000
>        argptr = prom_getcmdline();
>        if ((argptr = strstr(argptr, "ne_eth=")) == NULL) { 
>                argptr = prom_getcmdline();
>                strcat(argptr, " ne_eth=0x6020280,29");
>        }
>#endif

To you this you may need to modify this fn keeping two
things in mind.  A) setting *arcs_cmdline to 0 unconditionally
will clear the .config/hard-coded default.  B) If the board
supports a f/w command line string that should probably
over-ride and .config/hard-coded default.
>void __init
>prom_init_cmdline(int argc, char **argv)
>{
>       int i;  /* Always ignore the "-c" at argv[0] */
>
>       /* ignore all built-in args if any f/w args given */
>       if (argc > 1) {
>               *arcs_cmdline = '\0';
>       }
>       for (i = 1; i < argc; i++) {
>               if (i != 1) {
>                       strcat(arcs_cmdline, " ");
>               }
>               strcat(arcs_cmdline, argv[i]);
>       }
>}



Index: config-shared.in
===================================================================
RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v
retrieving revision 1.1.2.80
diff -u -r1.1.2.80 config-shared.in
--- config-shared.in    5 Aug 2003 11:13:39 -0000       1.1.2.80
+++ config-shared.in    6 Aug 2003 19:52:41 -0000
@@ -891,6 +891,11 @@
 fi
 endmenu
 
+bool 'Default kernel loader arguments' CONFIG_CMDLINE_BOOL
+if [ "$CONFIG_CMDLINE_BOOL" = "y" ] ; then
+   string 'Initial kernel command string' CONFIG_CMDLINE ""
+fi
+
 source drivers/mtd/Config.in
 
 source drivers/parport/Config.in
