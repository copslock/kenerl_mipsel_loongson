Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8RF04p15647
	for linux-mips-outgoing; Thu, 27 Sep 2001 08:00:04 -0700
Received: from coplin19.mips.com (host-3.mips.com [206.31.31.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8RF00D15611
	for <linux-mips@oss.sgi.com>; Thu, 27 Sep 2001 08:00:00 -0700
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id f8RExlm01749
	for <linux-mips@oss.sgi.com>; Thu, 27 Sep 2001 16:59:47 +0200
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Thu, 27 Sep 2001 16:59:47 +0200 (CEST)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: gcc crash
Message-ID: <Pine.LNX.4.30.0109271657250.1742-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

When I compile the following function with "gcc -O2" the compiler crashes.
Is this a known problem?

static float sp_f2l(float x)
{
    long l, *xl;
    float y;

    xl = (void *)&y;
    l = x;
    *xl = l;
    return y;
}

I use gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-97.2)

/Kjeld

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
