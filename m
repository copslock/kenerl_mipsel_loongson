Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2BMju015077
	for linux-mips-outgoing; Mon, 11 Mar 2002 14:45:56 -0800
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2BMjr915074
	for <linux-mips@oss.sgi.com>; Mon, 11 Mar 2002 14:45:53 -0800
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 11 Mar 2002 21:49:44 UT
Received: from venus (venus.esstech.com [193.5.205.5])
	by mail.esstech.com (8.11.6/8.11.6) with SMTP id g2BLha515617
	for <linux-mips@oss.sgi.com>; Mon, 11 Mar 2002 13:43:36 -0800 (PST)
Received: from bud.austin.esstech.com by venus (SMI-8.6/SMI-SVR4)
	id NAA23491; Mon, 11 Mar 2002 13:45:09 -0800
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id PAA24779; Mon, 11 Mar 2002 15:37:01 -0600
Message-ID: <3C8D26C8.2060903@esstech.com>
Date: Mon, 11 Mar 2002 15:51:04 -0600
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: pci config cycles on VRC-5477
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I'm studying the VRC-5477 code and I'm trying to understand how pci config
cycles can work reliably with the current code.  It looks like the pci
config code must execute with interrupts disabled, but I can't find code
that disables interrupts.  Can someone offer a few pointers?  Here's why
I ask...

All pci io, memory, and config accesses on the 5477 are performed through
two windows in the cpu address space.  Normally these two windows are configured
to perform pci memory and io accesses, and any driver can access pci io and
memory at any time.  In order to perform a pci config access, one of the two
windows must be remapped to perform pci config cycles.  The code in
read_config_dword() looks something like this:

- Call ddb_access_config_base() to reconfigure the window into pci memory space
   to access pci config space instead.

- Read from pci config space by reading from an offset into the window.

- Call ddb_close_config_base to restore the registers to the original values.

It looks like anything can interrupt this an try to perform a pci memory
access while the window is programmed to perfom config cycles.

Did I miss something, or is this a bug?

Thanks.

Gerald
