Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 09:21:53 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:6427 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8224851AbTBQJVw>;
	Mon, 17 Feb 2003 09:21:52 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 3905DB118; Mon, 17 Feb 2003 10:21:31 +0100 (CET)
To: TAKANO Ryousei <takano@os-omicron.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH][2/2] TANBAC TB0193 (L-Card+)
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030217133222.13f9adf8.takano@os-omicron.org> (TAKANO
 Ryousei's message of "Mon, 17 Feb 2003 13:32:22 +0900")
References: <20030217133222.13f9adf8.takano@os-omicron.org>
Date: Mon, 17 Feb 2003 10:21:31 +0100
Message-ID: <86r8a79s9w.fsf@trasno.mitica>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2.93
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "takano" == TAKANO Ryousei <takano@os-omicron.org> writes:

takano> Hi,
takano> This mail attaches tanbac-tb0193-drivers.patch.

a cople of comments:

+static __u32 tb0193_read32(struct map_info *map, unsigned long ofs)
        ^^^^^

plain uXX instead of __uXX should work on kernel land.

+static struct map_info tb0193_map = {
+	name:		"TANBAC TB0193 flash",
+	read8:		tb0193_read8,
+	read16:		tb0193_read16,
+	read32:		tb0193_read32,
+	copy_from:	tb0193_copy_from,
+	write8:		tb0193_write8,
+	write16:	tb0193_write16,
+	write32:	tb0193_write32,
+	copy_to:	tb0193_copy_to,
+
+	map_priv_1:	WINDOW_ADDR,
+};

Please, use C99 initializers.

+static unsigned long lcard_max_flash_size = 0x01000000;
+static struct mtd_partition lcard_partitions[] = {
+	{ 
+		name:		"root file system",
+		offset:		0x00000000,
+		size:		0x00c00000,
+	},{
+		name:		"monitor",
+		offset:		0x00c00000,
+		size:		0x00020000,
+                mask_flags:	MTD_WRITEABLE,
+	},{
+		name:		"reserved",
+		offset:		0x00c20000,
+		size:		0x000e0000,
+	},{
+		name:		"kernel",
+		offset:		0x00d00000,
+		size:		0x00300000,
+	},
+};

at least for the structs use the C99 initializers.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
