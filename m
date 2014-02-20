Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 03:53:48 +0100 (CET)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:52882 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870813AbaBTCxqOQ-T9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Feb 2014 03:53:46 +0100
Received: by mail-pd0-f177.google.com with SMTP id x10so1203095pdj.22
        for <multiple recipients>; Wed, 19 Feb 2014 18:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jsPcW399rDxsJoG2GyO7uP3+qDOVgyPBamhY3DIz77E=;
        b=ndX0f5cKps2O/Kcnd/nrXPmaTBtTj2yNvmJRup58YnaeslKG3KOW54OdgcqXo6BFoh
         50kDCD0/AWqLI8/Qq+CG4NQ+qva2F4Yjb4Ih/CHInR/xltiv4fJnImolJm8NVw2sXJOv
         DbN9U2ZCry9Dgf/thKEaug9NMN3gdBwczjqaNziLnegPXtVAonaiYIvY5ka4r7J72Gv3
         49Akw7NvIAcSRq3f+T3ARXDqCp51Xlw8UkK++hw8pxSfL8YOeFtPQjo55xdfalgnavWv
         Mcq4VMwaDGQJ9PS4YbGVsY5sFXLVXjNJrHMR0Vj2FcKmuvGVd8Es1BUVCgQFvokm0jQ0
         mP5Q==
MIME-Version: 1.0
X-Received: by 10.68.96.99 with SMTP id dr3mr43852020pbb.40.1392864819513;
 Wed, 19 Feb 2014 18:53:39 -0800 (PST)
Received: by 10.70.52.98 with HTTP; Wed, 19 Feb 2014 18:53:39 -0800 (PST)
In-Reply-To: <392C4BDEFF12D14FA57A3F30B283D7D140AE3A@LEMAIL01.le.imgtec.org>
References: <1392821678-18556-1-git-send-email-villerhsiao@gmail.com>
        <392C4BDEFF12D14FA57A3F30B283D7D140AE3A@LEMAIL01.le.imgtec.org>
Date:   Thu, 20 Feb 2014 10:53:39 +0800
Message-ID: <CAA1JSYKzssWBFkgtgQTpk3H49jDToefOmAey-X-5Ztt508e7iw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ftrace: Fix icache flush range error
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     Qais Yousef <Qais.Yousef@imgtec.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: villerhsiao@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Feb 19, 2014 at 11:51 PM, Qais Yousef <Qais.Yousef@imgtec.com> wrote:
>> -----Original Message-----
>> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
>> mips.org] On Behalf Of Viller Hsiao
>> Sent: 19 February 2014 14:55
>> To: linux-mips@linux-mips.org
>> Cc: Viller Hsiao; Steven Rostedt; Frederic Weisbecker; Ingo Molnar; Ralf Baechle
>> Subject: [PATCH] MIPS: ftrace: Fix icache flush range error
>>
>>
>> In 32-bit machine, the start address of flushing icache is wrong after calculated
>> address of 2nd modified instruction in function tracer. The start address is shifted
>> 4 bytes from ordinary calculation.
>>
>> This causes problem when the address of 1st instruction is the last word of one
>> cache line. It will not be flushed at this case.
>>
>> Signed-off-by: Viller Hsiao <villerhsiao@gmail.com>
>> ---
>>  arch/mips/kernel/ftrace.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c index
>> 185ba25..5bdc535 100644
>> --- a/arch/mips/kernel/ftrace.c
>> +++ b/arch/mips/kernel/ftrace.c
>> @@ -107,12 +107,12 @@ static int ftrace_modify_code_2(unsigned long ip,
>> unsigned int new_code1,
>>                               unsigned int new_code2)
>>  {
>>       int faulted;
>> +     unsigned long ip2 = ip + 4;
>
> I think better to omit this variable...
>
>>
>>       safe_store_code(new_code1, ip, faulted);
>>       if (unlikely(faulted))
>>               return -EFAULT;
>> -     ip += 4;
>> -     safe_store_code(new_code2, ip, faulted);
>> +     safe_store_code(new_code2, ip2, faulted);
>
> And just do the addition directly here instead.
>

Replacing ip2 to (ip + 4) causes compilation error because of the same
naming of symbolic operand and its input variable in safe_store().
----
arch/mips/kernel/ftrace.c:114:29: error: expected identifier before '(' token
  safe_store_code(new_code2, (ip + 4), faulted);
                             ^
/home/villerhsiao/official/linux-torvalds/arch/mips/include/asm/ftrace.h:61:6:
note: in definition of macro 'safe_store'
   : [dst] "r" (dst), [src] "r" (src)\
      ^
arch/mips/kernel/ftrace.c:114:2: note: in expansion of macro 'safe_store_code'
  safe_store_code(new_code2, (ip + 4), faulted);
  ^
/home/villerhsiao/official/linux-torvalds/arch/mips/include/asm/ftrace.h:61:11:
error: expected ':' or ')' before string constant
   : [dst] "r" (dst), [src] "r" (src)\
           ^
/home/villerhsiao/official/linux-torvalds/arch/mips/include/asm/ftrace.h:69:2:
note: in expansion of macro 'safe_store'
  safe_store(STR(sw), src, dst, error)
  ^
arch/mips/kernel/ftrace.c:114:2: note: in expansion of macro 'safe_store_code'
  safe_store_code(new_code2, (ip + 4), faulted);
  ^
----
If so, I will suggest to add the following patch to resolve it, (not
verified yet and I will do it before upload)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index ce35c9a..ec031e8 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -19,15 +19,15 @@
 extern void _mcount(void);
 #define mcount _mcount

-#define safe_load(load, src, dst, error) \
+#define safe_load(load, source, dest, error) \
 do { \
  asm volatile ( \
  "1: " load " %[" STR(dst) "], 0(%[" STR(src) "])\n"\
- "   li %[" STR(error) "], 0\n" \
+ "   li %[" STR(err) "], 0\n" \
  "2:\n" \
  \
  ".section .fixup, \"ax\"\n" \
- "3: li %[" STR(error) "], 1\n" \
+ "3: li %[" STR(err) "], 1\n" \
  "   j 2b\n" \
  ".previous\n" \
  \
@@ -35,21 +35,21 @@ do { \
  STR(PTR) "\t1b, 3b\n\t" \
  ".previous\n" \
  \
- : [dst] "=&r" (dst), [error] "=r" (error)\
- : [src] "r" (src) \
+ : [dst] "=&r" (dest), [err] "=r" (error)\
+ : [src] "r" (source) \
  : "memory" \
  ); \
 } while (0)

-#define safe_store(store, src, dst, error) \
+#define safe_store(store, source, dest, error) \
 do { \
  asm volatile ( \
  "1: " store " %[" STR(src) "], 0(%[" STR(dst) "])\n"\
- "   li %[" STR(error) "], 0\n" \
+ "   li %[" STR(err) "], 0\n" \
  "2:\n" \
  \
  ".section .fixup, \"ax\"\n" \
- "3: li %[" STR(error) "], 1\n" \
+ "3: li %[" STR(err) "], 1\n" \
  "   j 2b\n" \
  ".previous\n" \
  \
@@ -57,8 +57,8 @@ do { \
  STR(PTR) "\t1b, 3b\n\t" \
  ".previous\n" \
  \
- : [error] "=r" (error) \
- : [dst] "r" (dst), [src] "r" (src)\
+ : [err] "=r" (error) \
+ : [dst] "r" (dest), [src] "r" (source)\
  : "memory" \
  ); \
 } while (0)

>>       if (unlikely(faulted))
>>               return -EFAULT;
>>       flush_icache_range(ip, ip + 8); /* original ip + 12 */
>
> Care to fix this comment by removing it? I can't rationalise it and made me confused for a bit.
> If you do remove it please mention the change in the commit message.
Ok. I will check it.

>
> Nice catch by the way.
>
> Cheers,
> Qais
>
>> --
>> 1.8.4.3
>>
>

Best Regards,
Viller
