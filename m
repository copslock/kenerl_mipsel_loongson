Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 15:32:54 +0200 (CEST)
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:36483 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991162AbeJXNcue7YwV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 15:32:50 +0200
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id w9ODWecg050833;
        Wed, 24 Oct 2018 16:32:42 +0300 (EEST)
X-AuditID: 8b5b9d4d-91bff70000000e62-cf-5bd0747878a5
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id F8.2D.03682.87470DB5; Wed, 24 Oct 2018 16:32:40 +0300 (EEST)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id w9ODWeef018524;
        Wed, 24 Oct 2018 16:32:40 +0300
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 24 Oct 2018 16:32:40 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Rob Herring <robh@kernel.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] OF: Handle CMDLINE when /chosen node is not present
Organization: FORTH
In-Reply-To: <CAL_JsqKA6_saB7Ak=BZqSth6KAZ1g2srF5BsOQRGdE2+rmcR8w@mail.gmail.com>
References: <20181022224213.GA25145@bogus>
 <mhng-08dbc241-46e4-411b-ba13-32435abde7ad@palmer-si-x1c4>
 <CAL_JsqKA6_saB7Ak=BZqSth6KAZ1g2srF5BsOQRGdE2+rmcR8w@mail.gmail.com>
Message-ID: <8e420b9dee0f246fda8e018532737b1a@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsXSHc2orFtRciHa4M5sA4v5R86xWsx885/N
        YsLUSewW2z63sFk0vzvHbrF5wgJWi/97drA7sHvsnHWX3ePhpktMHptWdbJ5HF25lslj85J6
        j0vN19k9Pm+SC2CP4rJJSc3JLEst0rdL4Mp4fvAke8E18YoX0zqZGhgfCnUxcnJICJhIfP34
        l6mLkYtDSOAoo8S8vjlQziFGidnvWlghqkwlZu/tZASxeQUEJU7OfMICYjMLWEhMvbKfEcKW
        l2jeOpsZxGYRUJXoWLcDzGYT0JSYf+kgWL2IgKLE77ZprBD1Xxgl5m7yBbGFBbwlnn1eDBbn
        FxCW+HT3IpjNKRAose71FGaIg9YxSvz9uYMF4ggXieWvzzJCHKci8eH3A3YQW1RAWeLFiems
        ExiFZiG5dRaSW2chuXUBI/MqRoHEMmO9zORivbT8opIMvfSiTYzgCJnru4Px3AL7Q4wCHIxK
        PLwHas9HC7EmlhVX5gJDhoNZSYRX4D9QiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/hF+FBQgLp
        iSWp2ampBalFMFkmDk6pBkbf7ZJMD39mZky5W6soFRD67bWStmDqS82fC1mCtzbJ3BBPy/qT
        +q65v8dkg6/5uoshN948yMkLEVU4fMdNW+VjkprHys2NUkc0dpYxxTBxxq+XL5AJuPiH8e4r
        Odtvt9/Mfy1+J2HRv6O5ohmJBmL+vdmys7iPd9i25E5t8zbfbcLTo7bzuxJLcUaioRZzUXEi
        APw1ZcyMAgAA
Return-Path: <mick@ics.forth.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mick@ics.forth.gr
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

Στις 2018-10-23 17:30, Rob Herring έγραψε:
> On Mon, Oct 22, 2018 at 5:55 PM Palmer Dabbelt <palmer@sifive.com> 
> wrote:
>> 
>> On Mon, 22 Oct 2018 15:42:13 PDT (-0700), robh@kernel.org wrote:
>> > On Mon, Oct 15, 2018 at 05:20:10PM +0300, Nick Kossifidis wrote:
>> >> The /chosen node is optional so we should handle CMDLINE regardless
>> >> the presence of /chosen/bootargs. Move handling of CMDLINE in
>> >> early_init_dt_scan() instead.
>> >
>> > I looked at this a while back. I'm not sure this behavior can be changed
>> > without breaking some MIPS platforms that could be relying on the
>> > current behavior. But trying to make sense of the MIPS code is a
>> > challenge and they have some other issues in this area.
>> >
>> > Can't this be fixed by making /chosen manditory? I'd expect ultimately
>> > you are always going to need it.
>> >
>> > I'd rather not resort to making this per arch. There's also some effort
>> > to consolidate cmd line handling[1].
>> 
>> I'd rather make /chosen mandatory on RISC-V than to have per-arch 
>> handling, as
>> like you've said there's already too much duplication.  That said, it 
>> does seem
>> like a bug to me because the behavior seems somewhat arbitrary -- an 
>> empty
>> /chosen node causing the built-in command-line argument handling to go 
>> off the
>> rails just smells so buggy.
> 
> Yes. Probably need to do some archaeology on this code to figure out
> some of the expectations.
> 
>> If that's the case, could we at least have something like
>> "CONFIG_OF_CHOSEN_IS_MANDATORY" that provides a warning when there is 
>> no
>> /chosen node and is set on architecture where the spec mandates 
>> /chosen?
> 
> I'd be okay to make it a warning unconditionally. At least then we can
> find the cases that deviate and either fix them or understand their
> expectations.
> 
> Rob

I don't think we can make /chosen node mandatory since it's not 
specified as such
by the spec 
(https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.2).
No matter what we say from the kernel side, the device tree provider is 
not expected
to always provide the /chosen mode. Also device tree is not the only 
provider of
a command line, we might get a command line from different places 
per-arch (e.g. atags
on arm) or through EFI/ACPI/kexec as well. That's why my initial 
approach for RISC-V
was on the arch-specific code.

We shouldn't try to handle the built-in CMDLINE on each of the possible 
command line
providers and if we do we should at least make sure we don't depend on 
the presence
of a provided command line (which is the issue in this case).

I believe the best approach is to consolidate all the different CMDLINE 
approaches
for the various archs / providers and clean up the mess instead of 
re-implementing
the same thing again and again. I saw the patch you mentioned and it's a 
start.
I'll look more into it and try to come up with a similar one.

Nick
