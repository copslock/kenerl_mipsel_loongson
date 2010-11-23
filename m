Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 04:42:30 +0100 (CET)
Received: from bitwagon.com ([74.82.39.175]:49821 "HELO bitwagon.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1490975Ab0KWDmX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 04:42:23 +0100
Received: from f11-64.local ([67.171.188.169]) by bitwagon.com for <linux-mips@linux-mips.org>; Mon, 22 Nov 2010 19:42:10 -0800
Message-ID: <4CEB37F8.1050504@bitwagon.com>
Date:   Mon, 22 Nov 2010 19:41:44 -0800
From:   John Reiser <jreiser@bitwagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Arnaud Lacombe <lacombar@gmail.com>
CC:     Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org,
        wu zhangjin <wuzhangjin@gmail.com>
Subject: Re: Build failure triggered by recordmcount
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>      <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>  <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com> <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
In-Reply-To: <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jreiser@bitwagon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jreiser@bitwagon.com
Precedence: bulk
X-list: linux-mips

It looks to me like the change which introduced "virtual functions"
forgot about cross-platform endianness.  Can anyone please test this patch?
Thank you to Arnaud for supplying before+after data files do_mounts*.o.


recordmcount: Honor endianness in fn_ELF_R_INFO

---
 scripts/recordmcount.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 58e933a..3966717 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -119,7 +119,7 @@ static uint_t (*Elf_r_sym)(Elf_Rel const *rp) = fn_ELF_R_SYM;
  static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
 {
-	rp->r_info = ELF_R_INFO(sym, type);
+	rp->r_info = _w(ELF_R_INFO(sym, type));
 }
 static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
 -- 1.7.3.2


-- 
