Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 08:43:16 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:58137 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8224851AbTBQInP>;
	Mon, 17 Feb 2003 08:43:15 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 54028B118; Mon, 17 Feb 2003 09:42:51 +0100 (CET)
To: TAKANO Ryousei <takano@os-omicron.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH][1/2] TANBAC TB0193 (L-Card+)
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030217133213.6febe320.takano@os-omicron.org> (TAKANO
 Ryousei's message of "Mon, 17 Feb 2003 13:32:13 +0900")
References: <20030217133213.6febe320.takano@os-omicron.org>
Date: Mon, 17 Feb 2003 09:42:50 +0100
Message-ID: <86vfzj9u2d.fsf@trasno.mitica>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2.93
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "takano" == TAKANO Ryousei <takano@os-omicron.org> writes:

takano> Hi,
takano> I am new to the linux-mips kernel development, and I want to
takano> your sugestions.

takano> I added support of TANBAC TB0193 (L-Card+) which has VR4181.
takano> TB0193 is supported on Linux-VR's 2.4.0-test9 kernel, however
takano> I have not seen it on linux-mips cvs tree yet.

takano> The attatched patches is the following two parts:
takano> * tanbac-tb0193-arch.patch includes arch/mips/vr4181/tanbac-tb0193 directory.
takano> * tanbac-tb0193-drivers.patch includes cs89x0 patch and MTD flash driver
takano> from Linux-VR's 2.4.0-test9 kernel.

takano> And these are based on linux_2_4 tag cvs tree.

takano> I am now working for the PCMCIA staff.

+
+struct ide_ops tb0193_ide_ops = {
+	&tb0193_ide_default_irq,
+	&tb0193_ide_default_io_base,
+	&tb0193_ide_init_hwif_ports,
+	&tb0193_ide_request_irq,
+	&tb0193_ide_free_irq,
+	&tb0193_ide_check_region,
+	&tb0193_ide_request_region,
+	&tb0193_ide_release_region
+};


Please, use C99 initializers.


Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
