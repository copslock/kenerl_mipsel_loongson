Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 19:50:57 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:33332 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225243AbTCCTu4>;
	Mon, 3 Mar 2003 19:50:56 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 36F7C7BA; Mon,  3 Mar 2003 20:50:28 +0100 (CET)
To: "Kip Walker" <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] add CONFIG_DEBUG_INFO
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3E63B047.D3BA2A2C@broadcom.com> ("Kip Walker"'s message of
 "Mon, 03 Mar 2003 11:43:03 -0800")
References: <20030220113404.E7466@mvista.com> <3E63B047.D3BA2A2C@broadcom.com>
Date: Mon, 03 Mar 2003 20:50:28 +0100
Message-ID: <86d6l8fcvv.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "kip" == Kip Walker <kwalker@broadcom.com> writes:

Hi

kip> KipIndex: arch/mips/config-shared.in
kip> ===================================================================
kip> RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v
kip> retrieving revision 1.1.2.48
kip> diff -u -r1.1.2.48 config-shared.in
kip> --- arch/mips/config-shared.in	26 Feb 2003 21:14:23 -0000	1.1.2.48
kip> +++ arch/mips/config-shared.in	3 Mar 2003 19:41:11 -0000
kip> @@ -976,6 +976,7 @@
 
kip> bool 'Are you using a crosscompiler' CONFIG_CROSSCOMPILE
kip> bool 'Enable run-time debugging' CONFIG_RUNTIME_DEBUG
kip> +bool 'Debugging symbols' CONFIG_DEBUG_INFO
kip> bool 'Remote GDB kernel debugging' CONFIG_KGDB
kip> dep_bool '  Console output to GDB' CONFIG_GDB_CONSOLE $CONFIG_KGDB
kip> if [ "$CONFIG_SIBYTE_SB1xxx_SOC" = "y" ]; then

Once there, doing something like:

bool 'Remote GDB kernel debugging' CONFIG_KGDB
if [ "$CONFIG_KGDB" = "y" ]; then
   define_bool CONFIG_DEBUG_INFO n
else
   bool 'Debugging symbols' CONFIG_DEBUG_INFO
fi

And you can use single ifdefs in Makefiles?

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
