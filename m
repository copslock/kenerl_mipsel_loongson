Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 23:50:39 +0100 (CET)
Received: from prod-mail-xrelay07.akamai.com ([23.79.238.175]:38693 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdB0Wubynu5B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Feb 2017 23:50:31 +0100
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id E5EF643342D;
        Mon, 27 Feb 2017 22:50:25 +0000 (GMT)
Received: from prod-mail-relay11.akamai.com (prod-mail-relay11.akamai.com [172.27.118.250])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id BD4CD433417;
        Mon, 27 Feb 2017 22:50:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; s=a1;
        t=1488235825; bh=0ydoRGjMz3Yc1wMdvMpmFAuqvTm65Y5yNGwPyIu8Ijc=;
        l=3562; h=To:References:Cc:From:Date:In-Reply-To:From;
        b=HMnTfa3XMKtF9MnrvOmaEFkqP4jRbHcNOmnr25wl6SrvdcoK6QualokpUdvS5Q9tw
         nIuDWbHxN48S3cuA27iG6omqfdOkXoZyTbHEJAjp2uNzW8+UOkFfxYDRmPxGPnqjVI
         ev3Ki4oGJA+pR7Jiub3utH3LVQgEC8OTG2sHuEpM=
Received: from [172.28.13.148] (bos-lpjec.kendall.corp.akamai.com [172.28.13.148])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id AA6C91FC88;
        Mon, 27 Feb 2017 22:50:25 +0000 (GMT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     David Daney <ddaney@caviumnetworks.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@samba.org>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Zhigang Lu <zlu@ezchip.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
Date:   Mon, 27 Feb 2017 17:50:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
Content-Type: multipart/mixed;
 boundary="------------0A3EF28D71460612D7540AD2"
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbaron@akamai.com
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

This is a multi-part message in MIME format.
--------------0A3EF28D71460612D7540AD2
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 02/27/2017 05:45 PM, David Daney wrote:
> On 02/27/2017 02:36 PM, Steven Rostedt wrote:
>> On Mon, 27 Feb 2017 14:21:21 -0800
>> David Daney <ddaney@caviumnetworks.com> wrote:
>>
>>> See attached for mips.  It seems to do the right thing.
>>>
>>> I leave it as an exercise to the reader to fix the other architectures.
>>>
>>> Consult your own  binutils experts to verify that what I say is true.
>>
>> It may still just be safer to do the pointers instead. That way we
>> don't need to worry about some strange arch or off by one binutils
>> messing it up.
>
> Obviously it is your choice, but this is bog standard ELF linking.  In
> theory even the arrays of power-of-2 sized objects should also supply an
> entity size.  Think __ex_table and its ilk.
>
>
> The benefit of supplying an entsize is that you don't have to change the
> structure of the existing code and risk breaking something in the process.
>
> David Daney
>
>

Thanks for the suggestion! I would like to see if this resolves the ppc 
issue we had. I'm attaching a powerpc patch based on your suggestion. 
Hopefully, Sachin can try it.

Thanks,

-Jason

--------------0A3EF28D71460612D7540AD2
Content-Type: text/x-patch;
 name="ppc-pack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ppc-pack.patch"

diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 9a287e0ac8b1..3c5660e50f9a 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -19,14 +19,26 @@
 #define JUMP_ENTRY_TYPE		stringify_in_c(FTR_ENTRY_LONG)
 #define JUMP_LABEL_NOP_SIZE	4
 
+#ifdef CONFIG_PPC64
+typedef u64 jump_label_t;
+#else
+typedef u32 jump_label_t;
+#endif
+
+struct jump_entry {
+	jump_label_t code;
+	jump_label_t target;
+	jump_label_t key;
+};
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:\n\t"
 		 "nop # arch_static_branch\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".pushsection __jump_table,  \"awM\",@progbits, %1\n\t"
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
-		 : :  "i" (&((char *)key)[branch]) : : l_yes);
+		 : :  "i" (&((char *)key)[branch]), "i" (sizeof(struct jump_entry)) : : l_yes);
 
 	return false;
 l_yes:
@@ -37,32 +49,24 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm_volatile_goto("1:\n\t"
 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".pushsection __jump_table,  \"awM\",@progbits, %1\n\t"
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
-		 : :  "i" (&((char *)key)[branch]) : : l_yes);
+		 : :  "i" (&((char *)key)[branch]), "i" (sizeof(struct jump_entry)) : : l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
-#ifdef CONFIG_PPC64
-typedef u64 jump_label_t;
+
 #else
-typedef u32 jump_label_t;
-#endif
 
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
+#define ENTRY_SIZE (ULONG_SIZE * 3)
 
-#else
 #define ARCH_STATIC_BRANCH(LABEL, KEY)		\
 1098:	nop;					\
-	.pushsection __jump_table, "aw";	\
+	.pushsection __jump_table, "awM",@progbits,ENTRY_SIZE; \
 	FTR_ENTRY_LONG 1098b, LABEL, KEY;	\
 	.popsection
 #endif

--------------0A3EF28D71460612D7540AD2--
