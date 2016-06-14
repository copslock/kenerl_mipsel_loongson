Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:21:59 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33871 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041784AbcFNKV4uP3Jn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:21:56 +0200
Received: by mail-lf0-f65.google.com with SMTP id l184so3671132lfl.1;
        Tue, 14 Jun 2016 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Q2Gd8JFq+33Q5u8GhdCJKMlkRD9ppfNXl91VAyfrNqA=;
        b=OMgJUsxKNg8t3qkTtxUuLgimVQuVl3Sj4QEcqSqdA+VOssKDXz7IO8Xia+RarRXGsV
         UcRZ8SYV/uFsaJzOx2aYMwmxFUT1hiORCOTbS9erRo9q6ZoiOelyTg0Q1BkVxlym9PlR
         ZJWMUNY/lElIt1lgjTSY6WvT/qgiME7XBQD9Xrnj9Hk7TWOVQxA5Gj71ii4PAux+Db8/
         2uuXTuqiHNx2igz1E/WW7qdFkvkGWsAJvcjQEdlmHfGyiYAWzzbRbzvumlYPKlqzy1Jb
         dCsJoIjuXMc8NOTIyb4lrgoF4JsqJEO/+MqQlKnIAQ4Lghvz7GCvkIPP9q5UITjB0Dg9
         rrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Q2Gd8JFq+33Q5u8GhdCJKMlkRD9ppfNXl91VAyfrNqA=;
        b=C0R98tu5rRiNPvv4jWErLF794U484bITgb5AYQcq86ScU2Y3XNG0E3YUVpNCiS5b/e
         cqUaUyl8Kbf8GvcgiY+Y8ovQreBuGcxuLtsOenEwxBR41DTsJ0RmXJSJkuzNewjkjNUD
         OHP3MMYUDsrSqwHAr6oCNKpv4NPsBl0G4FwJtTo56qqgcqAQMRajUSMfMj++zynjQU59
         QiquTboQvO8VEoHOQ4wUhdvqNdGt3k8cAC7h423SJpXtNwCi5kcW4GVgSLqMBZuLVM2F
         8EhMu89n24nZnCuYrDNBztWi5vFn1Dr0y9K+J9PeieImgNp92Ehzdy+wdonxy7+0Fwq8
         N8HQ==
X-Gm-Message-State: ALyK8tIvUpKgrEvP7WazzSB12KgKfGpipM5IozRSw9mnnCUApHKE6jcEzP26+jLAgUwTgQ==
X-Received: by 10.25.151.74 with SMTP id z71mr1544801lfd.30.1465895743568;
        Tue, 14 Jun 2016 02:15:43 -0700 (PDT)
Received: from [192.168.10.150] (94-39-188-118.adsl-ull.clienti.tiscali.it. [94.39.188.118])
        by smtp.googlemail.com with ESMTPSA id p6sm3230688lbj.24.2016.06.14.02.15.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2016 02:15:42 -0700 (PDT)
Subject: Re: [PATCH 2/8] MIPS: KVM: Add kvm_aux trace event
To:     James Hogan <james.hogan@imgtec.com>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
 <1465893617-5774-3-git-send-email-james.hogan@imgtec.com>
 <20160614085541.GA17625@jhogan-linux.le.imgtec.org>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb4fef4f-c66f-42b8-18bc-89985e21a6d7@redhat.com>
Date:   Tue, 14 Jun 2016 11:15:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160614085541.GA17625@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 14/06/2016 10:55, James Hogan wrote:
> hmm, sorry, I don't know how i didn't spot when I checked these over
> that fpu_msa is still referred to here instead of aux. I'll post a V2 of
> this patch with s/fpu_msa/aux/.

I can fix it up to kvm_trace_symbol_aux_op and kvm_trace_symbol_aux_state.

diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index 32ac7cc82e13..f3ada591ca25 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -48,14 +48,14 @@ TRACE_EVENT(kvm_exit,
 #define KVM_TRACE_AUX_MSA		2
 #define KVM_TRACE_AUX_FPU_MSA		3
 
-#define kvm_trace_symbol_fpu_msa_op		\
+#define kvm_trace_symbol_aux_op		\
 	{ KVM_TRACE_AUX_RESTORE, "restore" },	\
 	{ KVM_TRACE_AUX_SAVE,    "save" },	\
 	{ KVM_TRACE_AUX_ENABLE,  "enable" },	\
 	{ KVM_TRACE_AUX_DISABLE, "disable" },	\
 	{ KVM_TRACE_AUX_DISCARD, "discard" }
 
-#define kvm_trace_symbol_fpu_msa_state		\
+#define kvm_trace_symbol_aux_state		\
 	{ KVM_TRACE_AUX_FPU,     "FPU" },	\
 	{ KVM_TRACE_AUX_MSA,     "MSA" },	\
 	{ KVM_TRACE_AUX_FPU_MSA, "FPU & MSA" }
@@ -78,9 +78,9 @@ TRACE_EVENT(kvm_aux,
 
 	    TP_printk("%s %s PC: 0x%08lx",
 		      __print_symbolic(__entry->op,
-				       kvm_trace_symbol_fpu_msa_op),
+				       kvm_trace_symbol_aux_op),
 		      __print_symbolic(__entry->state,
-				       kvm_trace_symbol_fpu_msa_state),
+				       kvm_trace_symbol_aux_state),
 		      __entry->pc)
 );
 

Paolo
