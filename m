Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 17:55:25 +0200 (CEST)
Received: from mail-ia0-f182.google.com ([209.85.210.182]:53716 "EHLO
        mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823005Ab3ELQxeWNHiN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 May 2013 18:53:34 +0200
Received: by mail-ia0-f182.google.com with SMTP id j5so4458303iaf.27
        for <multiple recipients>; Sun, 12 May 2013 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=JUDx5MxPfg8iFtjBMc4gFfqGgie3kjVWYlMO9gRtCYc=;
        b=GYvetAEsLoMrpeH9Z0qwhwBdWPKatdKsE1DWG2IAhEUrITk/GUPr2q7Zr024NyDDOa
         5lV73yBHvfs09baDCnCVbn7F3G58c7/yuqFCehCByWK/4u/5IJkLXVB5T2/WLPMURL0I
         3lAIlY2a8TLRF4aGt1pD0BoO3NkkEyc4K0MQV3UW/rMqJdTDrecqSRm7CUz3gTo1A2b0
         7ZHmVAEK01uFl7Jt0WHbk940DiW1ARSJfTeaOAmTbH/yZxKFfqeCR3q1d25DvAEUD8mC
         3zeD35a4mfnlwdsI/S41liCxXcZ/cCxTzfiyWQApeghJgw0fDx/Zkbhom/if7GatD9b+
         Uz2w==
MIME-Version: 1.0
X-Received: by 10.42.11.74 with SMTP id t10mr12321247ict.49.1368377607598;
 Sun, 12 May 2013 09:53:27 -0700 (PDT)
Received: by 10.50.153.169 with HTTP; Sun, 12 May 2013 09:53:27 -0700 (PDT)
In-Reply-To: <518D1F1D.2080504@gmail.com>
References: <20130510110729.GA7499@hades>
        <518D1F1D.2080504@gmail.com>
Date:   Mon, 13 May 2013 00:53:27 +0800
Message-ID: <CA+zhxNkvqYCPqghQ6t=GWyaYZgf9a5_5SF3xj5KbU6LfFyL1Xw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: detect sibling call in get_frame_info
From:   Tony Wu <tung7970@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=20cf301d425a3b5a8204dc883d00
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37066
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

--20cf301d425a3b5a8204dc883d00
Content-Type: text/plain; charset=ISO-8859-1

On Sat, May 11, 2013 at 12:23 AM, David Daney <ddaney.cavm@gmail.com> wrote:

> On 05/10/2013 04:07 AM, Tony Wu wrote:
>
>> Given a function, get_frame_info() analyzes its instructions
>> to figure out frame size and return address. get_frame_info()
>> works as follows:
>>
>> 1. analyze up to 128 instructions if the function size is unknown
>> 2. search for 'addiu/daddiu sp,sp,-immed' for frame size
>> 3. search for 'sw ra,offset(sp)' for return address
>> 4. end search when it sees jr/jal/jalr
>>
>> This leads to an issue when the given function is a sibling
>> call, example given as follows.
>>
>> 801ca110 <schedule>:
>> 801ca110:       8f820000        lw      v0,0(gp)
>> 801ca114:       8c420000        lw      v0,0(v0)
>> 801ca118:       080726f0        j       801c9bc0 <__schedule>
>> 801ca11c:       00000000        nop
>>
>> 801ca120 <io_schedule>:
>> 801ca120:       27bdffe8        addiu   sp,sp,-24
>> 801ca124:       3c028022        lui     v0,0x8022
>> 801ca128:       afbf0014        sw      ra,20(sp)
>>
>> In this case, get_frame_info() cannot properly detect schedule's
>> frame info, and eventually returns io_schedule's info instead.
>>
>> This patch adds sibling call check by detecting out of range jump.
>>
>
> I think this is more complex than it needs to be.  Also you already handle
> the case of a sib call via a function pointer ....
>
>
>
>
>> Signed-off-by: Tony Wu <tung7970@gmail.com>
>> ---
>>   arch/mips/kernel/process.c |   22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> index cfc742d..a794eb5 100644
>> --- a/arch/mips/kernel/process.c
>> +++ b/arch/mips/kernel/process.c
>> @@ -223,6 +223,9 @@ struct mips_frame_info {
>>         int             pc_offset;
>>   };
>>
>> +#define J_TARGET(pc,target)    \
>> +               (((unsigned long)(pc) & 0xf0000000) | ((target) << 2))
>> +
>>   static inline int is_ra_save_ins(union mips_instruction *ip)
>>   {
>>         /* sw / sd $ra, offset($sp) */
>> @@ -250,11 +253,25 @@ static inline int is_sp_move_ins(union
>> mips_instruction *ip)
>>         return 0;
>>   }
>>
>> +static inline int is_sibling_j_ins(union mips_instruction *ip,
>> +                                  unsigned long func_begin, unsigned
>> long func_end)
>> +{
>> +       if (ip->j_format.opcode == j_op) {
>> +               unsigned long addr;
>> +
>> +               addr = J_TARGET(ip, ip->j_format.target);
>> +               if (addr < func_begin || addr > func_end)
>> +                       return 1;
>> +       }
>> +       return 0;
>> +}
>> +
>>   static int get_frame_info(struct mips_frame_info *info)
>>   {
>>         union mips_instruction *ip = info->func;
>>         unsigned max_insns = info->func_size / sizeof(union
>> mips_instruction);
>>         unsigned i;
>> +       unsigned long func_begin, func_end;
>>
>>         info->pc_offset = -1;
>>         info->frame_size = 0;
>> @@ -266,10 +283,15 @@ static int get_frame_info(struct mips_frame_info
>> *info)
>>                 max_insns = 128U;       /* unknown function size */
>>         max_insns = min(128U, max_insns);
>>
>> +       func_begin = (unsigned long) info->func;
>> +       func_end = func_begin + max_insns * sizeof(union
>> mips_instruction);
>> +
>>         for (i = 0; i < max_insns; i++, ip++) {
>>
>>                 if (is_jal_jalr_jr_ins(ip))
>>                         break;
>>
>
> ... here.  So why not just add an unconditional J to the list detected,
> and get rid of all the rest of the patch?


I was hoping to catch out of range jump only, but I guess we could do
unconditional J since what we really care is sp and ra. And they happen
early in the given function if they ever exist. I have sent the v3 patch
according to your suggestion. It looks better.


>
>  +               if (is_sibling_j_ins(ip, func_begin, func_end))
>> +                       break;
>>                 if (!info->frame_size) {
>>                         if (is_sp_move_ins(ip))
>>                                 info->frame_size = -
>> ip->i_format.simmediate;
>>
>>
>

--20cf301d425a3b5a8204dc883d00
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Sat, May 11, 2013 at 12:23 AM, David Daney <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ddaney.cavm@gmail.com" target=3D"_blank">ddaney.cavm@gmail.com</=
a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 05/10/2013 04:07 AM, To=
ny Wu wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Given a function, get_frame_info() analyzes its instructions<br>
to figure out frame size and return address. get_frame_info()<br>
works as follows:<br>
<br>
1. analyze up to 128 instructions if the function size is unknown<br>
2. search for &#39;addiu/daddiu sp,sp,-immed&#39; for frame size<br>
3. search for &#39;sw ra,offset(sp)&#39; for return address<br>
4. end search when it sees jr/jal/jalr<br>
<br>
This leads to an issue when the given function is a sibling<br>
call, example given as follows.<br>
<br>
801ca110 &lt;schedule&gt;:<br>
801ca110: =A0 =A0 =A0 8f820000 =A0 =A0 =A0 =A0lw =A0 =A0 =A0v0,0(gp)<br>
801ca114: =A0 =A0 =A0 8c420000 =A0 =A0 =A0 =A0lw =A0 =A0 =A0v0,0(v0)<br>
801ca118: =A0 =A0 =A0 080726f0 =A0 =A0 =A0 =A0j =A0 =A0 =A0 801c9bc0 &lt;__=
schedule&gt;<br>
801ca11c: =A0 =A0 =A0 00000000 =A0 =A0 =A0 =A0nop<br>
<br>
801ca120 &lt;io_schedule&gt;:<br>
801ca120: =A0 =A0 =A0 27bdffe8 =A0 =A0 =A0 =A0addiu =A0 sp,sp,-24<br>
801ca124: =A0 =A0 =A0 3c028022 =A0 =A0 =A0 =A0lui =A0 =A0 v0,0x8022<br>
801ca128: =A0 =A0 =A0 afbf0014 =A0 =A0 =A0 =A0sw =A0 =A0 =A0ra,20(sp)<br>
<br>
In this case, get_frame_info() cannot properly detect schedule&#39;s<br>
frame info, and eventually returns io_schedule&#39;s info instead.<br>
<br>
This patch adds sibling call check by detecting out of range jump.<br>
</blockquote>
<br></div>
I think this is more complex than it needs to be. =A0Also you already handl=
e the case of a sib call via a function pointer ....<div><div class=3D"h5">=
<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Tony Wu &lt;<a href=3D"mailto:tung7970@gmail.com" target=3D"=
_blank">tung7970@gmail.com</a>&gt;<br>
---<br>
=A0 arch/mips/kernel/process.c | =A0 22 ++++++++++++++++++++++<br>
=A0 1 file changed, 22 insertions(+)<br>
<br>
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c<br>
index cfc742d..a794eb5 100644<br>
--- a/arch/mips/kernel/process.c<br>
+++ b/arch/mips/kernel/process.c<br>
@@ -223,6 +223,9 @@ struct mips_frame_info {<br>
=A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 pc_offset;<br>
=A0 };<br>
<br>
+#define J_TARGET(pc,target) =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((unsigned long)(pc) &amp; 0xf0000000) | ((t=
arget) &lt;&lt; 2))<br>
+<br>
=A0 static inline int is_ra_save_ins(union mips_instruction *ip)<br>
=A0 {<br>
=A0 =A0 =A0 =A0 /* sw / sd $ra, offset($sp) */<br>
@@ -250,11 +253,25 @@ static inline int is_sp_move_ins(union mips_instructi=
on *ip)<br>
=A0 =A0 =A0 =A0 return 0;<br>
=A0 }<br>
<br>
+static inline int is_sibling_j_ins(union mips_instruction *ip,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsign=
ed long func_begin, unsigned long func_end)<br>
+{<br>
+ =A0 =A0 =A0 if (ip-&gt;j_format.opcode =3D=3D j_op) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long addr;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D J_TARGET(ip, ip-&gt;j_format.target)=
;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (addr &lt; func_begin || addr &gt; func_en=
d)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
=A0 static int get_frame_info(struct mips_frame_info *info)<br>
=A0 {<br>
=A0 =A0 =A0 =A0 union mips_instruction *ip =3D info-&gt;func;<br>
=A0 =A0 =A0 =A0 unsigned max_insns =3D info-&gt;func_size / sizeof(union mi=
ps_instruction);<br>
=A0 =A0 =A0 =A0 unsigned i;<br>
+ =A0 =A0 =A0 unsigned long func_begin, func_end;<br>
<br>
=A0 =A0 =A0 =A0 info-&gt;pc_offset =3D -1;<br>
=A0 =A0 =A0 =A0 info-&gt;frame_size =3D 0;<br>
@@ -266,10 +283,15 @@ static int get_frame_info(struct mips_frame_info *inf=
o)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_insns =3D 128U; =A0 =A0 =A0 /* unknown =
function size */<br>
=A0 =A0 =A0 =A0 max_insns =3D min(128U, max_insns);<br>
<br>
+ =A0 =A0 =A0 func_begin =3D (unsigned long) info-&gt;func;<br>
+ =A0 =A0 =A0 func_end =3D func_begin + max_insns * sizeof(union mips_instr=
uction);<br>
+<br>
=A0 =A0 =A0 =A0 for (i =3D 0; i &lt; max_insns; i++, ip++) {<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_jal_jalr_jr_ins(ip))<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
</blockquote>
<br></div></div>
... here. =A0So why not just add an unconditional J to the list detected, a=
nd get rid of all the rest of the patch?</blockquote><div><br></div><div st=
yle>I was hoping to catch out of range jump only, but I guess we could do u=
nconditional J since what we really care is sp and ra. And they happen earl=
y in the given function if they ever exist. I have sent the v3 patch accord=
ing to your suggestion. It looks better.</div>
<div style>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><d=
iv class=3D"h5">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_sibling_j_ins(ip, func_begin, func_end=
))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!info-&gt;frame_size) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_sp_move_ins(ip))<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;fr=
ame_size =3D - ip-&gt;i_format.simmediate;<br>
<br>
</blockquote>
<br>
</div></div></blockquote></div><br></div></div>

--20cf301d425a3b5a8204dc883d00--
