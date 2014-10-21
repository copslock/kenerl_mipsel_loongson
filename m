Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 22:05:01 +0200 (CEST)
Received: from mail-qg0-f46.google.com ([209.85.192.46]:55336 "EHLO
        mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012067AbaJUUE7jLKwJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 22:04:59 +0200
Received: by mail-qg0-f46.google.com with SMTP id z60so1493403qgd.5
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XnrvIhmq+u201IvXOqKAdpddOSMlHx9/5/CxAofduBk=;
        b=IC6ZJQ0BT5a0RZgzr/Bdlhj/x4aHnG0K2HRdeOznAgbJfmvJXkHamZ3RhPK+gjEv/I
         /97QDtfBz4dwvl9DMab4LTUoGZoqan4aH9O1c2xXTFghwR9yc6JY1/nRLXukes/azpEn
         k6RgOIHB8ypL5fAkyKBZpysyzJY/czL0gXcKEo9gqbpMP/as6IM7jIONBAdsBpogfw0r
         aGAudeKTQgG2OcI9cxrd4H6ytpZ+wxf2hp8wblp5UzE3QS1FCPiXNis8xqQ2BE9P9/QK
         6tlcHt6IFYDzzGbE4PxH0zbCSb8hZGMpIZvE72bOD0EhfFCybHyP+iT8+P5YCXQ8tJ40
         nEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=XnrvIhmq+u201IvXOqKAdpddOSMlHx9/5/CxAofduBk=;
        b=Df+Ov9uqUkrRLdCRHfVaPsTr2jfQSoieZihJXxEa8Q59MWj21MWXR6d/TCJ63rq27e
         1/p7SoNYOmLjJwwMcgVnWChLYRBq8OQi0gntLBhm7x9D8tQwQJQR4ZK4N3ZEMmbEUsPx
         WvnANINSpf4owSyP2HknQ+vEnoVW/9ztV1zlnpESjuf7pPaTqJ/1QONH+k7kkywsnc7U
         sn3m2kjhnWLOp7nCSz/SdU1CbiGEu/wjiouWG/mPRIwdQG8V3bY7mZPxTA39khFJcBHZ
         +lgXulWNPhtgRDjKaHiWCvtOtwzaSDJHr5z3z9xA15NzyRdIbUanjgEYOwlwzj4KSYnj
         vw3Q==
X-Gm-Message-State: ALoCoQle4KoGt18pdJJ87lwqQZUwRJS2cuw/pULQhcMYOoI3TOLH0uVEwberzC4Y4VVzJoEQfWoZ
X-Received: by 10.140.83.203 with SMTP id j69mr47177940qgd.89.1413921892114;
 Tue, 21 Oct 2014 13:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.164.210 with HTTP; Tue, 21 Oct 2014 13:04:31 -0700 (PDT)
In-Reply-To: <CAErSpo4ZhxFxRT9=ww8F8bKkfQe5jQTtfSvw2XfxAPvHzArKTQ@mail.gmail.com>
References: <20141015165957.4063.66741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20141015170609.4063.10668.stgit@bhelgaas-glaptop2.roam.corp.google.com> <CAErSpo4ZhxFxRT9=ww8F8bKkfQe5jQTtfSvw2XfxAPvHzArKTQ@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 21 Oct 2014 14:04:31 -0600
Message-ID: <CAErSpo5MCzoSaUtYOBrO4qg48USqg+9YRMWhVLx7vEY3hdab-Q@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] MIPS: Remove "weak" from platform_maar_init() declaration
To:     Jason Wessel <jason.wessel@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Eric Paris <eparis@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Wed, Oct 15, 2014 at 5:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc linux-mips]
>
> On Wed, Oct 15, 2014 at 11:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> arch/mips/mm/init.c provides a default platform_maar_init() definition
>> explicitly marked "weak".  arch/mips/mti-malta/malta-memory.c provides its
>> own definition intended to override the default, but the "weak" attribute
>> on the declaration applied to this as well, so the linker chose one based
>> on link order (see 10629d711ed7 ("PCI: Remove __weak annotation from
>> pcibios_get_phb_of_node decl")).
>>
>> Remove the "weak" attribute from the declaration so we always prefer a
>> non-weak definition over the weak one, independent of link order.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> CC: linux-mips@linux-mips.org

Dropping this because no MIPS folks responded.

>> ---
>>  arch/mips/include/asm/maar.h |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.h
>> index 6c62b0f899c0..b02891f9caaf 100644
>> --- a/arch/mips/include/asm/maar.h
>> +++ b/arch/mips/include/asm/maar.h
>> @@ -26,7 +26,7 @@
>>   *
>>   * Return:     The number of MAAR pairs configured.
>>   */
>> -unsigned __weak platform_maar_init(unsigned num_pairs);
>> +unsigned platform_maar_init(unsigned num_pairs);
>>
>>  /**
>>   * write_maar_pair() - write to a pair of MAARs
>>
