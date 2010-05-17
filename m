Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2010 05:58:39 +0200 (CEST)
Received: from mail-yw0-f172.google.com ([209.85.211.172]:56542 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491753Ab0EQD6g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 May 2010 05:58:36 +0200
Received: by ywh2 with SMTP id 2so2305183ywh.0
        for <multiple recipients>; Sun, 16 May 2010 20:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=GAB3JkXhaWRxYxze8wRT1FVPui3TBMBk1Si5BaWWWHw=;
        b=PtpFMdkPcBeAf9aFtYWd/IEhmSPAeE5MSBP1dAs1GMtnnDFXUA1v0cDoGL3bbkWEh1
         bJ8qDj1ChpZFvlLsH/zDBaMotUvZLwMC815ESeUme2MvR02ltXgvHADNRMSMaEgL4Iqg
         fB4zDujwb8F+VRn6MqwCRgRHki3Ds5Vi+Y6dU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=w/GBx66ZZEzw/yR6JgKIlldkdk6wlf3yuOMzInHwGT9QjF+sg7Fykop9jEkEXT54cm
         xhxpkaQJz3Ls63Oc3s+Xw3KBaGdgxZpEmYrbnKD3wbQMjwaJI2zR922axTHcyWBveTuI
         5ISE4UbggT4NdH+Ee/6S+WwmyIukSwoj1/mb4=
MIME-Version: 1.0
Received: by 10.150.160.14 with SMTP id i14mr5728148ybe.144.1274068708121; 
        Sun, 16 May 2010 20:58:28 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Sun, 16 May 2010 20:58:28 -0700 (PDT)
In-Reply-To: <4BEEC902.2080006@mvista.com>
References: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
         <1273937815-4781-8-git-send-email-dengcheng.zhu@gmail.com>
         <4BEEC902.2080006@mvista.com>
Date:   Mon, 17 May 2010 11:58:28 +0800
Message-ID: <AANLkTik2py0aE_5-qQfVhT2zuWzY5eiZjxupuFeyUcki@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] MIPS/perf-events: allow modules to get pmu number 
        of counters
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Content-Type: multipart/alternative; boundary=000e0cd75516c45b930486c23c08
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

--000e0cd75516c45b930486c23c08
Content-Type: text/plain; charset=ISO-8859-1

Thanks!

Will do that next version.


Deng-Cheng


2010/5/16 Sergei Shtylyov <sshtylyov@mvista.com>

> Hello.
>
>
> Deng-Cheng Zhu wrote:
>
>  Oprofile module needs a function to get the number of pmu counters in its
>> high level interfaces.
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
>> ---
>>  arch/mips/include/asm/pmu.h   |    1 +
>>  arch/mips/kernel/perf_event.c |   11 +++++++++++
>>  2 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
>> index 16d4fcd..023a915 100644
>> --- a/arch/mips/include/asm/pmu.h
>> +++ b/arch/mips/include/asm/pmu.h
>> @@ -114,5 +114,6 @@ enum mips_pmu_id {
>>  extern const char *mips_pmu_names[];
>>  extern enum mips_pmu_id mipspmu_get_pmu_id(void);
>> +extern int mipspmu_get_max_events(void);
>>  #endif /* __MIPS_PMU_H__ */
>> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
>> index 67d301d..6f95220 100644
>> --- a/arch/mips/kernel/perf_event.c
>> +++ b/arch/mips/kernel/perf_event.c
>> @@ -145,6 +145,17 @@ enum mips_pmu_id mipspmu_get_pmu_id(void)
>>  }
>>  EXPORT_SYMBOL_GPL(mipspmu_get_pmu_id);
>>  +int mipspmu_get_max_events(void)
>> +{
>> +       int max_events = 0;
>> +
>> +       if (mipspmu)
>> +               max_events = mipspmu->num_counters;
>> +
>> +       return max_events;
>>
>>
>
>  Why not simply:
>
>   return mispmu ? mipspmu->num_counters : 0;
>
> WBR, Sergei
>
>

--000e0cd75516c45b930486c23c08
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks!<br>
<br>
Will do that next version.<br>
<br>
<br>
Deng-Cheng<br><br><br><div class=3D"gmail_quote">2010/5/16 Sergei Shtylyov =
<span dir=3D"ltr">&lt;<a href=3D"mailto:sshtylyov@mvista.com">sshtylyov@mvi=
sta.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">
Hello.<div><div></div><div class=3D"h5"><br>
<br>
Deng-Cheng Zhu wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Oprofile module needs a function to get the number of pmu counters in its<b=
r>
high level interfaces.<br>
<br>
Signed-off-by: Deng-Cheng Zhu &lt;<a href=3D"mailto:dengcheng.zhu@gmail.com=
" target=3D"_blank">dengcheng.zhu@gmail.com</a>&gt;<br>
---<br>
=A0arch/mips/include/asm/pmu.h =A0 | =A0 =A01 +<br>
=A0arch/mips/kernel/perf_event.c | =A0 11 +++++++++++<br>
=A02 files changed, 12 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h<br>
index 16d4fcd..023a915 100644<br>
--- a/arch/mips/include/asm/pmu.h<br>
+++ b/arch/mips/include/asm/pmu.h<br>
@@ -114,5 +114,6 @@ enum mips_pmu_id {<br>
=A0extern const char *mips_pmu_names[];<br>
 =A0extern enum mips_pmu_id mipspmu_get_pmu_id(void);<br>
+extern int mipspmu_get_max_events(void);<br>
 =A0#endif /* __MIPS_PMU_H__ */<br>
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c<=
br>
index 67d301d..6f95220 100644<br>
--- a/arch/mips/kernel/perf_event.c<br>
+++ b/arch/mips/kernel/perf_event.c<br>
@@ -145,6 +145,17 @@ enum mips_pmu_id mipspmu_get_pmu_id(void)<br>
=A0}<br>
=A0EXPORT_SYMBOL_GPL(mipspmu_get_pmu_id);<br>
=A0+int mipspmu_get_max_events(void)<br>
+{<br>
+ =A0 =A0 =A0 int max_events =3D 0;<br>
+<br>
+ =A0 =A0 =A0 if (mipspmu)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_events =3D mipspmu-&gt;num_counters;<br>
+<br>
+ =A0 =A0 =A0 return max_events;<br>
 =A0<br>
</blockquote>
<br></div></div>
 =A0Why not simply:<br>
<br>
 =A0 return mispmu ? mipspmu-&gt;num_counters : 0;<br>
<br>
WBR, Sergei<br>
<br>
</blockquote></div><br>

--000e0cd75516c45b930486c23c08--
