Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 09:17:46 +0000 (GMT)
Received: from mail.libertysurf.net ([IPv6:::ffff:213.36.80.91]:49959 "EHLO
	mail.libertysurf.net") by linux-mips.org with ESMTP
	id <S8225201AbTA0JRp>; Mon, 27 Jan 2003 09:17:45 +0000
Received: from localhost.localdomain (212.83.190.254) by mail.libertysurf.net (6.5.026)
        id 3DF56A5800679BD2; Mon, 27 Jan 2003 10:15:38 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
From: Eric Botcazou <ebotcazou@libertysurf.fr>
To: Guido Guenther <agx@sigxcpu.org>
Subject: Re: optimizer problem in linux-mips gcc-3.2?
Date: Mon, 27 Jan 2003 10:14:41 +0100
User-Agent: KMail/1.4.3
Cc: gcc@gcc.gnu.org, linux-mips@linux-mips.org
References: <20030126215942.GD14230@bogon.ms20.nix>
In-Reply-To: <20030126215942.GD14230@bogon.ms20.nix>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301271014.41715.ebotcazou@libertysurf.fr>
Return-Path: <ebotcazou@libertysurf.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebotcazou@libertysurf.fr
Precedence: bulk
X-list: linux-mips

> glibc's string/tester and string/inl-tester fail when compiled with
> Debian's "gcc version 3.2.2 20030109 (Debian prerelease)" on linux-mips
> (big endian) and -O2 or -Os. I've tried to strip down the testcase as
> far as possible and suspect that gcc miscompiles it. It works fine with
> Debian's "gcc version 2.95.4 20011002" and with the above gcc-3.2.2 and
> optimations turned off, -O3 and -O1:

Fill in a bug report (see http://gcc.gnu.org/bugs.html).

-- 
Eric Botcazou
